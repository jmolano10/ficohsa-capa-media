xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns0:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_ARMAR_MENSAJE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/armarInfoParametrosRemesas/";

declare function xf:armarInfoParametrosRemesas($requestHeader1 as element(ns2:RequestHeader),
    $consultaRemesas1 as element(ns0:consultaRemesas),
    $idContratoT24 as xs:string)
    as element(ns1:InputParameters) 
    {
        <ns1:InputParameters>
            <ns1:CODIGO_CONTRATO>{ $idContratoT24 }</ns1:CODIGO_CONTRATO>
            <ns1:TIPO_OPERACION>1</ns1:TIPO_OPERACION>
            <ns1:TIPO_PARAM>REQ</ns1:TIPO_PARAM>
            <ns1:APLICACION>ENQ</ns1:APLICACION>
            <ns1:INFO>
            	<ns1:DATA>
            		<ns1:NAME>corresponsalBranchCode</ns1:NAME>
            		<ns1:VALUE>{ data($consultaRemesas1/CORRESPONSAL_BRANCHCODE) }</ns1:VALUE>
            	</ns1:DATA>           
                <ns1:DATA>
                    <ns1:NAME>primaryKey</ns1:NAME>
                    <ns1:VALUE>{ data($consultaRemesas1/REMITTANCE_ID) }</ns1:VALUE>
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>UserName</ns1:NAME>
                    <ns1:VALUE>{ data($requestHeader1/Authentication/UserName) }</ns1:VALUE>
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>CONTRAC_ID</ns1:NAME>
                    <ns1:VALUE>{ data($idContratoT24) }</ns1:VALUE>
                </ns1:DATA>
                <ns1:DATA>
                	<ns1:NAME>coreRunningDate</ns1:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns1:VALUE>{ $strDateTime }</ns1:VALUE>
						)					
					}
                </ns1:DATA>
                <ns1:DATA>
                	<ns1:NAME>transactionID</ns1:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns1:VALUE>{ $strDateTime }</ns1:VALUE>
						)					
					}
                </ns1:DATA>    
                
                
                {
                    for $INFO at $i  in $consultaRemesas1/ADDITIONAL_INFO/INFO
                    return
                    (
                           <ns1:DATA>
                                  <ns1:NAME>{data($INFO/NAME)}</ns1:NAME>
                                  <ns1:VALUE>{data($INFO/VALUE)}</ns1:VALUE>
                           </ns1:DATA>
                    )
               }
                  
            </ns1:INFO>                        
        </ns1:InputParameters>
	};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaRemesas1 as element(ns0:consultaRemesas) external;
declare variable $idContratoT24 as xs:string external;

xf:armarInfoParametrosRemesas($requestHeader1,
    $consultaRemesas1,
    $idContratoT24)