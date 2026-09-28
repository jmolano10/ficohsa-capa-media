(:: pragma bea:global-element-parameter parameter="$actualizaSistemas1" element="ns0:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:recordCustomerData" location="../../../BusinessServices/ABKGT/actualizaClientes/wsdl/abandef_08032021.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace ns1 = "http://service.ficohsa.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionClienteAbanksIn/";

declare function xf:actualizacionClienteAbanksIn($actualizaSistemas1 as element(ns0:actualizaSistemas))
    as element(ns1:recordCustomerData) {
        <ns1:recordCustomerData>
        {
            for $uuid in $actualizaSistemas1/CUSTOMER_DATA/CUSTOMER_INFO/INFO[NAME = "UUID"]
            return  
            <UUID>{ data($uuid/VALUE) }</UUID>
        }
        <CUSTOMER_DATA>
                 {
                 let $actualizaSistemas := $actualizaSistemas1/CUSTOMER_DATA
                 return(
                 	<CUSTOMER_INFO>
                   		{
                      		for $customerInfo in $actualizaSistemas/CUSTOMER_INFO/INFO
                      		return
                   				<INFO>
                        			<NAME>{ string($customerInfo/NAME/text()) }</NAME>
                        			<VALUE>{ string($customerInfo/VALUE/text()) }</VALUE>
                        			<STATUS>{ string($customerInfo/STATUS/text()) }</STATUS>
                    			</INFO>
                   		}
                 	</CUSTOMER_INFO>,
                	<IDENTIFICATION_INFO>
                   		{
                      		for $identificationInfo in $actualizaSistemas/IDENTIFICATION_INFO/INFO
                      		return
                   				<INFO>
                        			<NAME>{ string($identificationInfo/NAME/text()) }</NAME>
                        			<VALUE>{ string($identificationInfo/VALUE/text()) }</VALUE>
                        			<STATUS>{ string($identificationInfo/STATUS/text()) }</STATUS>
                    			</INFO>
                   		}
                 	</IDENTIFICATION_INFO>,
                    for  $ADDRESS in $actualizaSistemas/ADDRESS_INFO
                    return
                 	<ADDRESS_INFO>
                   		{
                      		for $addressInfo in $ADDRESS/INFO
                      		return
                   				<INFO>
                        			<NAME>{ string($addressInfo/NAME/text()) }</NAME>
                        			<VALUE>{ string($addressInfo/VALUE/text()) }</VALUE>
                        			<STATUS>{ string($addressInfo/STATUS/text()) }</STATUS>
                    			</INFO>
                   		}
                 	</ADDRESS_INFO>,
                    for  $PHONE in $actualizaSistemas/PHONE_INFO
                    return
                 	<PHONE_INFO>
                   		{
                      		for $phoneInfo in $PHONE/INFO
                      		return
                   				<INFO>
                        			<NAME>{ string($phoneInfo/NAME/text()) }</NAME>
                        			<VALUE>{ string($phoneInfo/VALUE/text()) }</VALUE>
                        			<STATUS>{ string($phoneInfo/STATUS/text()) }</STATUS>
                    			</INFO>
                   		}
                 	</PHONE_INFO>,
                    for  $EMAIL in $actualizaSistemas/EMAIL_INFO
                    return
                 	<EMAIL_INFO>
                   		{
                      		for $emailInfo in $EMAIL/INFO
                      		return
                   				<INFO>
                        			<NAME>{ string($emailInfo/NAME/text()) }</NAME>
                        			<VALUE>{ string($emailInfo/VALUE/text()) }</VALUE>
                        			<STATUS>{ string($emailInfo/STATUS/text()) }</STATUS>
                    			</INFO>
                   		}
                 	</EMAIL_INFO>,
                 	<CONTROL_INFO>
                   		{
                      		for $controlInfo in $actualizaSistemas/CONTROL_INFO/INFO
                      		return
                   				<INFO>
                        			<NAME>{ string($controlInfo/NAME/text()) }</NAME>
                        			<VALUE>{ string($controlInfo/VALUE/text()) }</VALUE>
                        			<STATUS>{ string($controlInfo/STATUS/text()) }</STATUS>
                    			</INFO>
                   		}
                 	</CONTROL_INFO>,
                 	<SYSTEM_INFO>
                   		{
                      		for $systemInfo in $actualizaSistemas/SYSTEM_INFO/INFO
                      		return
                   				<INFO>
                        			<NAME>{ string($systemInfo/NAME/text()) }</NAME>
                        			<VALUE>{ string($systemInfo/VALUE/text()) }</VALUE>
                        			<STATUS>{ string($systemInfo/STATUS/text()) }</STATUS>
                    			</INFO>
                   		}
                 	</SYSTEM_INFO>
                    )
                 }
        </CUSTOMER_DATA>
        </ns1:recordCustomerData>
};

declare variable $actualizaSistemas1 as element(ns0:actualizaSistemas) external;

xf:actualizacionClienteAbanksIn($actualizaSistemas1)