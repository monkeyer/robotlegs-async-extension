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
	 * execute sub commands in parallel
	 *
	 * @author piku
	 *
	 */
	public class ParallelCommand extends AbstractGroupCommand
	{
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param commandClasses
		 * @param responder
		 *
		 */
		override protected function executeCommands(commandClasses:Vector.<Class>, executionResponder:IResponder):void
		{
			var executionCount:int=0;

			if (!executionResponder)
			{
				throw new IllegalOperationError("no responder");
			}

			if (!commandClasses.length)
			{
				executionResponder.complete();
				return;
			}

			var results:Array=[];

			var onCommandCompleteFunction:Function=function(data:Object=null):void
			{
				executionCount--;
				if (data)
				{
					results.push(data);
				}
				if (!executionCount)
				{
					executionResponder.complete(results);
				}
			}

			executionCount=commandClasses.length;
			for each (var commandClass:Class in commandClasses)
			{
				executor.executeCommand(commandClass, null, new Responder(onCommandCompleteFunction, executionResponder.error));
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
