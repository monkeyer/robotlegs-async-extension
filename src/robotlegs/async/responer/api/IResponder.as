/**
 *
 */
package robotlegs.async.responer.api
{

	/**
	 *
	 * @author Peter
	 *
	 */
	public interface IResponder
	{        
        /**
         * 
         * @param completeFunction
         * @param errorFunction
         * 
         */
        function set(completeFunction:Function=null, errorFunction:Function=null): void
            
		/**
		 *
		 * @param data
		 *
		 */
		function complete(data:Object=null):void;

		/**
		 *
		 * @param info
		 *
		 */
		function error(info:Object=null):void;
		
		/**
		 *
		 *
		 */
		function dispose():void;
	}
}
