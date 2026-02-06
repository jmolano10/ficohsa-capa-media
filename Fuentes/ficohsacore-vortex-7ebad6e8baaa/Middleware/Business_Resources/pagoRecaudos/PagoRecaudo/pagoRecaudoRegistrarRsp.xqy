xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoResponse1" element="ns1:pagoRecaudoResponse" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../recaudos/Resources/RegistrarRspRecaudo/xsd/OSB_REG_BITACORA_RECAUDO_RSP.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarRspRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoRegistrarRsp/";

declare function reqParams($paramArray as xs:string , $paramPos as xs:integer) as xs:string {
	let $PARAM_ARRAY := fn:tokenize($paramArray,"\|")
	return $PARAM_ARRAY[$paramPos]
};

declare function xf:pagoRecaudoRegistrarRsp($responseHeader1 as element(ns2:ResponseHeader),
    $pagoRecaudoResponse1 as element(ns1:pagoRecaudoResponse),
    $string1 as xs:string,
    $string2 as xs:string,
    $string3 as xs:string,
    $string4 as xs:string,
    $string5 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_UUID>{ $string1 }</ns0:P_UUID>
            {
                let $COD_CONVENIO := reqParams($string4,2)
                return
                <ns0:P_CODIGO_CONVENIO>{ $COD_CONVENIO }</ns0:P_CODIGO_CONVENIO>
            }
            {
                let $COD_DEUDOR := reqParams($string4,3)
                return
                <ns0:P_CODIGO_DEUDOR>{ $COD_DEUDOR }</ns0:P_CODIGO_DEUDOR>
            }            
            <ns0:P_CODIGO_OPERACION>2</ns0:P_CODIGO_OPERACION>
            <ns0:P_FECHA>{ $string2 }</ns0:P_FECHA>
            {
                let $USUARIO := reqParams($string4,1)
                return
            	<ns0:P_USUARIO>{ $USUARIO }</ns0:P_USUARIO>
           	}
           	<ns0:P_REQ_UUID>{ $string3 }</ns0:P_REQ_UUID>            
            {
                for $successIndicator in $responseHeader1/successIndicator
                return
                    <ns0:P_COD_ERROR_CORE>{ data($successIndicator) }</ns0:P_COD_ERROR_CORE>
            }
            {
                let $result :=
                    for $messages in $responseHeader1/messages
                    return
                        if (empty($messages/text())) then (
                        	<ns0:P_MSG_ERROR_CORE>{ data($messages) }</ns0:P_MSG_ERROR_CORE>
                        ) else ( 
                        	<ns0:P_MSG_ERROR_CORE>{ concat(substring(data($messages),1,1000),"; ",$string5) }</ns0:P_MSG_ERROR_CORE>
                        )
                return
                    $result[1]
            }
            <ns0:P_RESPONSE>{ $pagoRecaudoResponse1 }</ns0:P_RESPONSE>
        </ns0:InputParameters>
};

declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $pagoRecaudoResponse1 as element(ns1:pagoRecaudoResponse) external;
declare variable $string1 as xs:string external;
declare variable $string2 as xs:string external;
declare variable $string3 as xs:string external;
declare variable $string4 as xs:string external;
declare variable $string5 as xs:string external;

xf:pagoRecaudoRegistrarRsp($responseHeader1,
    $pagoRecaudoResponse1,
    $string1,
    $string2,
    $string3,
    $string4,
    $string5)