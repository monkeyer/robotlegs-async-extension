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

	import flash.utils.setTimeout;

	import org.swiftsuspenders.Injector;

	import robotlegs.async.responer.api.ICompositeResponder;
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 *
	 * @author piku
	 *
	 */
	public class AsyncCommand extends Command
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject(optional="true")]
		/**
		 *
		 * logger
		 *
		 */
		public var log:ILogger;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject]
		/**
		 *
		 * logger
		 *
		 */
		public var injector:Injector;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject]
		/**
		 *
		 */
		public var responder:ICompositeResponder;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[PostConstruct]
		/**
		 *
		 */
		public function initialize():void
		{
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[PreDestroy]
		/**
		 *
		 */
		public function dispose():void
		{
			if (responder)
			{
				responder.dispose();
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @inheritDoc
		 *
		 */
		override public function execute():void
		{
			// NullCommand			
			setTimeout(complete, 1);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @inheritDoc
		 *
		 */
		public function complete(data:Object=null):void
		{

			if (log)
			{
				log.debug("completed {0}", [this]);
			}

			responder.complete(data);
			injector.destroyInstance(this);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////        

		/**
		 *
		 * @inheritDoc
		 *
		 */
		public function error(info:Object=null):void
		{
			if (log)
			{
				log.error("error {0}=>{1}", [this, info]);
			}
			responder.error(info);
			injector.destroyInstance(this);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
