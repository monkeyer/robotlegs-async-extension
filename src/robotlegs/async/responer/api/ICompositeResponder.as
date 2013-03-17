package robotlegs.async.responer.api
{

	/**
	 * 
	 * @author Peter
	 * 
	 */
	public interface ICompositeResponder extends IResponder
	{

		/**
		 * 
		 * @param responder
		 * @return 
		 * 
		 */
		function addResponder(responder:IResponder):ICompositeResponder;

		/**
		 * 
		 * @param responder
		 * @return 
		 * 
		 */
		function removeResponder(responder:IResponder):ICompositeResponder;		

	}
}
