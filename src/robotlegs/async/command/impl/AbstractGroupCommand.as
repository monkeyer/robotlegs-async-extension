/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors'
 * written
 * permission is hereby prohibited.
 */
package robotlegs.async.command.impl
{

	import flash.errors.IllegalOperationError;
	import flash.utils.setTimeout;

	import robotlegs.async.command.api.ICommandExecutor;
	import robotlegs.async.responer.api.IResponder;
	import robotlegs.async.responer.impl.Responder;

	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class AbstractGroupCommand extends AsyncCommand
	{
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public var running:Boolean=false;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject]
		/**
		 *
		 */
		public var executor:ICommandExecutor;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * commands list
		 *
		 * @private
		 *
		 */
		public var subCommands:Vector.<Class>=new Vector.<Class>;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * Adds command to sequence
		 *
		 * @param subCommand
		 *
		 */
		public function addCommand(subCommand:Class):void
		{
			subCommands.push(subCommand);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param subCommand
		 *
		 */
		public function removeCommands(subCommand:Class):void
		{
			var index:int=subCommands.indexOf(subCommand);
			subCommands.splice(index, 1);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @inheritDoc
		 *
		 */
		final override public function execute():void
		{
			var responder:IResponder=new Responder(complete, error);
			setTimeout(executeCommands, 1, subCommands, responder);
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param commandClasses
		 * @param responder
		 *
		 */
		protected function executeCommands(commandClasses:Vector.<Class>, responder:IResponder):void
		{
			throw new IllegalOperationError("not implemented");
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		[PostConstruct]
		/**
		 *
		 */
		override public function initialize():void
		{
			createCommands();
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		protected function createCommands():void
		{
			throw new IllegalOperationError("not implemented");
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[PreDestroy]
		/**
		 *
		 *
		 */
		override public function dispose():void
		{
			subCommands.length=0;
			super.dispose();
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
