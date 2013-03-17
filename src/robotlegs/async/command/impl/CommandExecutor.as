/**
 *
 * Copyright 2012(C) by Piotr Kucharski.
 * email: suspendmode@gmail.com
 * mobile: +48 791 630 277
 *
 * All rights reserved. Any use, copying, modification, distribution and selling of this software and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 *
 */
package robotlegs.async.command.impl
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.describeType;

	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.reflection.Reflector;

	import robotlegs.async.command.api.ICommandExecutor;
	import robotlegs.async.responer.api.IResponder;
	import robotlegs.async.responer.impl.ResponseEvent;
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class CommandExecutor implements ICommandExecutor
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject(optional="true")]
		/**
		 *
		 * logger
		 *
		 */
		public var log:ILogger;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject]
		/**
		 *
		 */
		public var reflector:Reflector;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////


		[Inject]
		/**
		 *
		 */
		public var injector:Injector;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param commandClass
		 * @param event
		 * @param responder
		 *
		 */
		public function executeCommand(commandClass:Class, event:Event=null, responder:IResponder=null):void
		{
			if (log)
			{
				log.debug("execute {0}=>{1}", [commandClass, responder]);
			}

			var command:Command=createCommand(commandClass, event);

			if (command is AsyncCommand)
			{
				if (responder)
				{
					AsyncCommand(command).responder.addResponder(responder);
				}
				if (event && event is ResponseEvent)
				{
					AsyncCommand(command).responder.addResponder(ResponseEvent(event).responder);
				}
				command.execute();
			}
			else
			{
				try
				{
					command.execute();
				}
				catch (error:Error)

				{
					if (log)
					{
						log.error("execute command error {0}=>{1}", [command, error]);
					}
					if (responder)
					{
						responder.error(error);
					}
				}
				finally
				{
					if (log)
					{
						log.debug("completed {0}", [command]);
					}
					if (responder)
					{
						responder.complete();
					}
				}

			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		protected function createCommand(commandClass:Class, event:Event=null):Command
		{

			if (event)
			{
				var eventConstructor:Class=event["constructor"] as Class;

				injector.map(eventConstructor).toValue(event);
				injector.map(Event).toValue(event);
			}
			const command:Command=injector.instantiateUnmapped(commandClass);
			if (event)
			{
				injector.unmap(eventConstructor);
				injector.unmap(Event);
			}
			return command;
		}


		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 * Internal
		 *
		 * Collection of command classes that have been verified to implement an
		 * <code>execute</code> method
		 */
		protected var verifiedCommandClasses:Dictionary=new Dictionary(true);

		/**
		 *
		 * @param commandClass
		 *
		 */
		protected function verifyCommandClass(commandClass:Class):void
		{

			if (!verifiedCommandClasses[commandClass])
			{
				verifiedCommandClasses[commandClass]=describeType(commandClass).factory.method.(@name == "execute").length();

				if (!verifiedCommandClasses[commandClass])
				{
					throw new IllegalOperationError("execute not implemented in " + commandClass);
				}
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
