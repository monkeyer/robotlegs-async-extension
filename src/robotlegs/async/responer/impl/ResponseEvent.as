/**
 *
 */
package robotlegs.async.responer.impl
{

	import flash.events.Event;

	import robotlegs.async.responer.api.IResponder;

	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class ResponseEvent extends Event
	{
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public var responder:IResponder;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param type
		 * @param responder
		 * @param bubbles
		 * @param cancelable
		 *
		 */
		public function ResponseEvent(type:String, responder:IResponder=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.responder=responder;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @inheritDoc
		 *
		 */
		override public function clone():Event
		{
			var cloned:ResponseEvent=new ResponseEvent(type, responder, bubbles, cancelable);
			return cloned;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
