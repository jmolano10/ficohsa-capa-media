(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/creaCuentaClienteHeaderOut/";

declare function xf:creaCuentaClienteHeaderOut($errorCode as xs:string,
    $validationMessage as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $errorCode }</successIndicator>
            {
				if ($errorCode != "Success") then (
					<messages>{ $validationMessage }</messages>
				) else (
				)
			}
            
        </ns0:ResponseHeader>
};

declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:creaCuentaClienteHeaderOut($errorCode,
    $validationMessage)