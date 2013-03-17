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
package robotlegs.async
{
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.reflection.DescribeTypeJSONReflector;
	import org.swiftsuspenders.reflection.Reflector;

	import robotlegs.async.command.api.ICommandExecutor;
	import robotlegs.async.command.impl.AsyncCommand;
	import robotlegs.async.command.impl.CommandExecutor;
	import robotlegs.async.command.impl.ParallelCommand;
	import robotlegs.async.command.impl.SequenceCommand;
	import robotlegs.async.responer.api.ICompositeResponder;
	import robotlegs.async.responer.api.IResponder;
	import robotlegs.async.responer.impl.CompositeResponderProvider;
	import robotlegs.async.responer.impl.Responder;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;


	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class AsyncExtension implements IExtension
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /**
         * 
         * @param context
         * 
         */
		public function extend(context:IContext):void
		{
			const injector:Injector=context.injector;

			if (!injector.hasMapping(Reflector))
			{
				injector.map(Reflector).toType(DescribeTypeJSONReflector);
			}

			injector.map(AsyncCommand).toType(AsyncCommand);
			injector.map(ParallelCommand).toType(ParallelCommand);
			injector.map(SequenceCommand).toType(SequenceCommand);

			injector.map(ICompositeResponder).toProvider(new CompositeResponderProvider());

			injector.map(IResponder).toType(Responder);

			injector.map(ICommandExecutor).toSingleton(CommandExecutor);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
