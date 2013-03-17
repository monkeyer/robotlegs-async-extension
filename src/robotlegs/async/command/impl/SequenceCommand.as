/**
 *
 * Copyright (C) Piotr Kucharski 2012 email: suspendmode@gmail.com
 * mobile: +48 791 630 277
 *
 * All rights reserved. Any use, copying, modification,
 * distribution and selling of this software and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 *
 * Use this code to do whatever you want, just don't claim it as your own, because
 * I wrote it. Not you!
 *
 */
package robotlegs.async.command.impl
{
	import flash.errors.IllegalOperationError;
	
	import robotlegs.async.responer.api.IResponder;
	import robotlegs.async.responer.impl.Responder;

	/**
	 *
	 * execute sub commands in sequence
	 *
	 * @author piku
	 *
	 */
	public class SequenceCommand extends AbstractGroupCommand
	{        
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		private var sequence:Vector.<Class>;

		/**
		 *
		 */
		private var results:Array;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////		

		/**
		 *
		 * @param commandClasses
		 * @param responder
		 *
		 */
		override protected function executeCommands(commandClasses:Vector.<Class>, responder:IResponder):void
		{

			if (!responder)
			{
				throw new IllegalOperationError("no responder");
			}

			if (!commandClasses.length)
			{
				responder.complete();
				return;
			}

			sequence=commandClasses.concat();

			results=[];

			var onCommandCompleteFunction:Function=function(data:Object=null):void
			{
				if (data)
				{
					results.push(data);
				}
				if (!sequence.length)
				{
					responder.complete(results);
				}
				else
				{
					nextCommand(new Responder(onCommandCompleteFunction, responder.error));
				}
			}

			nextCommand(new Responder(onCommandCompleteFunction, responder.error));
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private function nextCommand(commandResponder:IResponder):void
		{
			var commandClass:Class=sequence.shift();
			executor.executeCommand(commandClass, null, commandResponder);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		[PreDestroy]
		/**
		 *
		 *
		 */
		override public function dispose():void
		{
			super.dispose();
			sequence=null;
			results=null;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
