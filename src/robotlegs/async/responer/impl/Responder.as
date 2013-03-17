/**
 *
 */
package robotlegs.async.responer.impl
{
	import robotlegs.async.responer.api.IResponder;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.impl.UID;


	/**
	 *
	 * @author Peter
	 *
	 */
	public class Responder implements IResponder
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject(optional="true")]
		/**
		 *
		 */
		public var log:ILogger;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public var completeFunction:Function;

		/**
		 *
		 */
		public var errorFunction:Function;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public var id:String;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param completeFunction
		 * @param errorFunction
		 *
		 */
		public function Responder(completeFunction:Function=null, errorFunction:Function=null, id:String=null)
		{
			if (!id)
			{
				id=UID.create(this)
			}
			this.id=id;
			super();
			set(completeFunction, errorFunction);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param completeFunction
		 * @param errorFunction
		 *
		 */
		public function set(completeFunction:Function=null, errorFunction:Function=null):void
		{
			if (completeFunction != null)
			{
				this.completeFunction=completeFunction;
			}
			if (errorFunction != null)
			{
				this.errorFunction=errorFunction;
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param data
		 *
		 */
		public function complete(data:Object=null):void
		{
			if (completeFunction != null)
			{
				if (log)
				{
					log.debug("{0} responder->complete:{1}", [this, data]);
				}

				if (completeFunction.length == 1)
				{
					completeFunction(data);
				}
				else if (completeFunction.length == 2)
				{
					completeFunction(data, this);
				}
				else
				{
					completeFunction();
				}
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param info
		 *
		 */
		public function error(info:Object=null):void
		{
			if (errorFunction != null)
			{
				if (log)
				{
					log.debug("{0} responder->error:{1}", [this, info]);
				}
				if (errorFunction.length == 1)
				{
					errorFunction(info);
				}
				else if (errorFunction.length == 2)
				{
					errorFunction(info, this);
				}
				else
				{
					errorFunction();
				}
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[PreDestroy]
		public function dispose():void
		{
			completeFunction=null;
			errorFunction=null;
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @return
		 *
		 */
		public function toString():String
		{
			if (id)
			{
				return "[Responder id:" + id + "]"
			}
			else
			{
				return "[Responder]";
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
