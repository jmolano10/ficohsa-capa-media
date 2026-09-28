(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoACHResponse" location="../xsd/validaProductoACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/consultaDetallesCuentaGTOut/";

declare function xf:consultaDetallesCuentaGTOut($outputParameters1 as element(ns1:OutputParameters),
    $validaProductoACH as element(ns0:validaProductoACH))
    as element(ns0:validaProductoACHResponse) {
        <ns0:validaProductoACHResponse>
            <PRODUCT_NUMBER>{ data($validaProductoACH/PRODUCT_NUMBER) }</PRODUCT_NUMBER>
            {
                for $ACCOUNT_NAME in $outputParameters1/ns1:ACCOUNT_NAME
                return
                 if($outputParameters1/ns1:INACTIVE_MARKER/text()= "ACT")
                    then
                    <PRODUCT_NAME>{ data($ACCOUNT_NAME) }</PRODUCT_NAME>
                    else
                    (<PRODUCT_NAME></PRODUCT_NAME>)
            }
            {
                for $CURRENCY in $outputParameters1/ns1:CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
             for $INACTIVE_MARKER in $outputParameters1/ns1:INACTIVE_MARKER
             return
                    if($outputParameters1/ns1:INACTIVE_MARKER/text()= "ACT")
                    then
                    (<PRODUCT_STATUS></PRODUCT_STATUS>)
                    else
                    (<PRODUCT_STATUS>{data($INACTIVE_MARKER)}</PRODUCT_STATUS>)
            }
            <PRODUCT_TYPE>{ data($validaProductoACH/PRODUCT_TYPE) }</PRODUCT_TYPE>
            <UUID>{ data($validaProductoACH/UUID) }</UUID>
            {
                for $KV_PAIRS in $validaProductoACH/KV_PAIRS
                return
                    <KV_PAIRS>{ $KV_PAIRS/@* , $KV_PAIRS/node() }</KV_PAIRS>
            }
            {
            	if($outputParameters1/ns1:ERROR_CODE/text()= "SUCCESS" and $outputParameters1/ns1:INACTIVE_MARKER/text()= "ACT")
            	then
            	(<HIT>false</HIT>,
 				<FOUND>true</FOUND>)
            	else
            	(<HIT>true</HIT>,
            	<FOUND>false</FOUND>)
            }
        </ns0:validaProductoACHResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $validaProductoACH as element(ns0:validaProductoACH) external;

xf:consultaDetallesCuentaGTOut($outputParameters1,
    $validaProductoACH)