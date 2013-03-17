/**
 *
 */
package robotlegs.async.responer.impl
{
	import robotlegs.async.responer.api.ICompositeResponder;
	import robotlegs.async.responer.api.IResponder;

	/**
	 *
	 * @author Peter
	 *
	 */
	public class CompositeResponder extends Responder implements ICompositeResponder
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public var responders:Vector.<IResponder>=new Vector.<IResponder>();

		///////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param id
		 *
		 */
		public function CompositeResponder(id:String=null)
		{
			super(this.completeFunction, this.errorFunction, id);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param data
		 *
		 */
		private function completeFunction(data:Object=null):void
		{
			if (responders.length)
			{
				if (log)
				{
					log.debug("{0} composite responder->complete:{1}", [this, data]);
				}
				for each (var responder:IResponder in responders)
				{
					responder.complete(data);
				}
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param info
		 *
		 */
		private function errorFunction(info:Object=null):void
		{
			if (responders.length)
			{
				if (log)
				{
					log.debug("{0} composite responder->error:{1}", [this, info]);
				}
				for each (var responder:IResponder in responders)
				{
					responder.error(info);
				}
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param responder
		 * @return
		 *
		 */
		public function addResponder(responder:IResponder):ICompositeResponder
		{
			if (log)
			{
				log.debug("{0} addResponder {1}", [this, responder]);
			}
			responders.push(responder);
			return this;
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param responder
		 * @return
		 *
		 */
		public function removeResponder(responder:IResponder):ICompositeResponder
		{
			var i:int=responders.indexOf(responder);
			if (i != -1)
			{
				if (log)
				{
					log.debug("{0} removeResponder {1}", [this, responder]);
				}
				responders.splice(i, 1);
			}
			return this;
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////

		[PreDestroy]
		/**
		 *
		 *
		 */
		override public function dispose():void
		{
			while (responders.length)
			{
				var responder:IResponder=responders.shift();
				responder.dispose();
			}
			super.dispose();
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
