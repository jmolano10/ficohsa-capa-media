xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataGT/conDatoTarjetas_v3/xsd/conDatoTarjetas_v3_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validaProductoACH1" element="ns1:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaProductoACHResponse" location="../xsd/validaProductoACHTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v3";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/conDatoTarjetasGTOut/";

declare function xf:conDatoTarjetasGTOut($outputParameters1 as element(ns0:OutputParameters),
    $validaProductoACH1 as element(ns1:validaProductoACH),
    $productNumber as xs:string)
    as element(ns1:validaProductoACHResponse) {
        <ns1:validaProductoACHResponse>
            <PRODUCT_NUMBER>{ $productNumber }</PRODUCT_NUMBER>
            <CURRENCY>{ data($validaProductoACH1/PRODUCT_CURRENCY) }</CURRENCY>
            <PRODUCT_STATUS>{ $outputParameters1/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='estadocuenta']/text() }</PRODUCT_STATUS>
             {
            	if(data($outputParameters1/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='estadocuenta']/text()) !="")
            	then
            	(<PRODUCT_NAME></PRODUCT_NAME>)
            	else
            	(<PRODUCT_NAME>{ $outputParameters1/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='accountname']/text() }</PRODUCT_NAME>)
            }
            <PRODUCT_TYPE>{ data($validaProductoACH1/PRODUCT_TYPE) }</PRODUCT_TYPE>
            <UUID>{ data($validaProductoACH1/UUID) }</UUID>
            {
                for $KV_PAIRS in $validaProductoACH1/KV_PAIRS
                return
                    <KV_PAIRS>{ $KV_PAIRS/@* , $KV_PAIRS/node() }</KV_PAIRS>
            }
            {
            	if(data($outputParameters1/ns0:CodigoError/text()) = -1 and data($outputParameters1/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='estadocuenta']/text()) !="")
            	then
            	(<HIT>true</HIT>,
 				<FOUND>false</FOUND>)
            	else
            	(<HIT>false</HIT>,
            	<FOUND>true</FOUND>)
            }
        </ns1:validaProductoACHResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $validaProductoACH1 as element(ns1:validaProductoACH) external;
declare variable $productNumber as xs:string external;

xf:conDatoTarjetasGTOut($outputParameters1,
    $validaProductoACH1,
    $productNumber)