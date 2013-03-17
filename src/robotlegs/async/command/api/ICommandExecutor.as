/**
 *
 */
package robotlegs.async.command.api
{
	import flash.events.Event;
	
	import robotlegs.async.responer.api.IResponder;

	/**
	 *
	 * @author Peter
	 *
	 */
	public interface ICommandExecutor
	{
		/**
		 *
		 * @param commandClass
		 * @param event
		 * @param responder
		 *
		 */
		function executeCommand(commandClass:Class, event:Event = null, responder:IResponder = null):void;
	}
}
