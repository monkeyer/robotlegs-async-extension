package robotlegs.async.responer.api
{

	public interface IResponderBuilder
	{
		function setCompleteFunction(reference:Function, scope:Object=null, ... parameters:Array):IResponderBuilder;
		function setErrorFunction(reference:Function, scope:Object=null, ... parameters:Array):IResponderBuilder;
		function setCancelFunction(reference:Function, scope:Object=null, ... parameters:Array):IResponderBuilder;
		function setStatusFunction(reference:Function, scope:Object=null, ... parameters:Array):IResponderBuilder;
		function setCustomFunction(name: String, reference:Function, scope:Object=null, ... parameters:Array):IResponderBuilder;
		
		function unsetCompleteFunction(reference:Function, scope:Object=null):IResponderBuilder;
		function unsetErrorFunction(reference:Function, scope:Object=null):IResponderBuilder;
		function unsetCancelFunction(reference:Function, scope:Object=null):IResponderBuilder;
		function unsetStatusFunction(reference:Function, scope:Object=null):IResponderBuilder;
		function unsetCustomFunction(name: String, reference:Function, scope:Object=null):IResponderBuilder;

		function build():IResponder;

	}
}
