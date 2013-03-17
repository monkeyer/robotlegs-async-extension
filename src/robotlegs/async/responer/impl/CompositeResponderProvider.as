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
package robotlegs.async.responer.impl
{
	import flash.utils.Dictionary;

	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.dependencyproviders.DependencyProvider;

	import robotlegs.bender.framework.api.ILogger;


	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class CompositeResponderProvider implements DependencyProvider
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function apply(targetType:Class, activeInjector:Injector, injectParameters:Dictionary):Object
		{
			var responder:CompositeResponder=new CompositeResponder("injected responder");
			if (activeInjector.hasMapping(ILogger))
			{
				responder.log=activeInjector.getInstance(ILogger);
			}
			return responder;
		}

		public function destroy():void
		{
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
