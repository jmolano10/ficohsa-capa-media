xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaBuroInterno/xsd/ConsultaBuroInterno_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaBuroInternoResponse" location="../xsd/consultaBuroInternoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBuroInternoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaBuroInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBuroInterno/xq/consultaBuroInternoPAOut2/";

declare function xf:consultaBuroInternoPAOut2($outputParameters as element(ns1:OutputParameters),
$customerId as xs:string)
    as element(ns0:consultaBuroInternoResponse) {
        <ns0:consultaBuroInternoResponse>
            <CUSTOMER_ID>{ data($customerId) }</CUSTOMER_ID>
            <PRODUCTS>
            {
            for $product in 1 to fn:count($outputParameters/ns1:PV_CODIGO_EMPRESA/ns1:PV_CODIGO_EMPRESA_ITEM)
            return(
            	<PRODUCT>
            		{
                		<COMPANY_CODE>{ data($outputParameters/ns1:PV_CODIGO_EMPRESA/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</COMPANY_CODE>,
						<AGENCY_CODE>{ data($outputParameters/ns1:PV_CODIGO_AGENCIA/ns1:PV_CODIGO_EMPRESA_ITEM[$product])  }</AGENCY_CODE>,
                    	<CODE>{ data($outputParameters/ns1:PV_CODIGO_SUBAPLICACION/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</CODE>,
                   		<NUMBER>{ data($outputParameters/ns1:PV_NUMERO_PRODUCTO/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</NUMBER>,
                    	<DOCUMENT>{ data($outputParameters/ns1:PV_NUMERO_OBLIGACION/ns1:PV_NUMERO_OBLIGACION_ITEM[$product]) }</DOCUMENT>,
                    	<TYPE>{ data($outputParameters/ns1:PV_TIPO_PRODUCTO/ns1:PV_NUMERO_OBLIGACION_ITEM[$product]) }</TYPE>,
                    	<LOAN_TYPE>{ data($outputParameters/ns1:PV_TIPO_PRESTAMO/ns1:PV_NUMERO_OBLIGACION_ITEM[$product]) }</LOAN_TYPE>,
                    	<DESCRIPTION>{ data($outputParameters/ns1:PV_DESCRIPCION_PRODUCTO/ns1:PV_NUMERO_OBLIGACION_ITEM[$product]) }</DESCRIPTION>,
                    	<STATUS>{ data($outputParameters/ns1:PV_ESTADO_PRODUCTO/ns1:PV_NUMERO_OBLIGACION_ITEM[$product]) }</STATUS>,
                    	<OPEN_DATE>{ data($outputParameters/ns1:PV_FECHA_APERTURA/ns1:PV_FECHA_APERTURA_ITEM[$product]) }</OPEN_DATE>,
                    	<CANCELLATION_DATE>{ data($outputParameters/ns1:PV_FECHA_CANCELACION/ns1:PV_FECHA_APERTURA_ITEM[$product]) }</CANCELLATION_DATE>,
                    	<EXPIRATION_DATE>{ data($outputParameters/ns1:PV_FECHA_VENCIMIENTO/ns1:PV_FECHA_APERTURA_ITEM[$product]) }</EXPIRATION_DATE>,
                    	<GUARANTEE>{ data($outputParameters/ns1:PV_TIPO_GARANTIA/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</GUARANTEE>,
                    	<TERM>{ data($outputParameters/ns1:PV_PLAZO/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</TERM>,
                    	<PAST_DUE_HISTORY>{ data($outputParameters/ns1:PV_HISTORIAL_MORA/ns1:PV_NUMERO_OBLIGACION_ITEM[$product]) }</PAST_DUE_HISTORY>,
                    	<CURRENCY>{ data($outputParameters/ns1:PV_MONEDA/ns1:PV_NUMERO_OBLIGACION_ITEM[$product]) }</CURRENCY>,
                    	<AMOUNT>{ data($outputParameters/ns1:PV_MONTO_OTORGADO/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</AMOUNT>,
                    	<BALANCE_TO_DATE>{ data($outputParameters/ns1:PV_SALDO_CAPITAL/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</BALANCE_TO_DATE>,
                    	<LOAN_INSTALLMENT>{ data($outputParameters/ns1:PV_CUOTA_PRODUCTO/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</LOAN_INSTALLMENT>,
                    	<LOAN_RATE>{ data($outputParameters/ns1:PV_TASA_CAMBIO/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</LOAN_RATE>,
                    	<LEVEL_OF_DEBT>{ data($outputParameters/ns1:PV_DIAS_MOROSIDAD/ns1:PV_CODIGO_EMPRESA_ITEM[$product]) }</LEVEL_OF_DEBT>
            		}
            	</PRODUCT>
            ) 
            }
            </PRODUCTS>
        </ns0:consultaBuroInternoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare	variable $customerId as xs:string external;

xf:consultaBuroInternoPAOut2($outputParameters,$customerId)