(:: pragma bea:global-element-parameter parameter="$outputParametersIN" element="ns1:OutputParameters" location="../../../BusinessServices/Cobis/ActualizacionDatosCliente/xsd/ActualizacionDatosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizaDatosClienteResponse" location="../xsd/actualizacionDatosCliente.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ActualizacionDatosCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizacionDatosCliente/xq/actualizaDatosClienteaNIOut/";

declare function xf:actualizaDatosClienteaNIOut($outputParametersIN as element(ns1:OutputParameters),
    $Customer as xs:string)
    as element(ns0:actualizaDatosClienteResponse) {
        <ns0:actualizaDatosClienteResponse>
            <CUSTOMER_ID>{ $Customer }</CUSTOMER_ID>
            <ADDRESS_INFO>
                {
                    for $direccion in $outputParametersIN/ns1:RowSet[1]/ns1:Row
                    return
                        <ADDRESS_ITEM>
                            <ADDRESS_TYPE>{ data($direccion/ns1:Column[@name='ADDRESS_TYPE']) }</ADDRESS_TYPE>
                            <ADDRESS_LINE_1>{ data($direccion/ns1:Column[@name='ADDRESS_LINE_1']) }</ADDRESS_LINE_1>
                            <IS_MAIN_ADDRESS>
                               { 
                                    	if (data($direccion/ns1:Column[@name='MAIN_ADDRESS_YES_NO']/text()) = "1") then (
                                        	"S"
										) else ( "N" )                                         
                                 	}
                               </IS_MAIN_ADDRESS>
                        </ADDRESS_ITEM>
                }
            </ADDRESS_INFO>
        </ns0:actualizaDatosClienteResponse>
};

declare variable $outputParametersIN as element(ns1:OutputParameters) external;
declare variable $Customer as xs:string external;

xf:actualizaDatosClienteaNIOut($outputParametersIN,
    $Customer)
