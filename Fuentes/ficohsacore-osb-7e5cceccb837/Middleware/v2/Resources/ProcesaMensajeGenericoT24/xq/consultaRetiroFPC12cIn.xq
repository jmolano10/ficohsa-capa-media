(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns2:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:FPCWithdrawalConsultation" location="../../../BusinessServices/ConsultaRetiroFPC/Resources/v1.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaRetiroFPC12cIn/";

declare function xf:consultaRetiroFPC12cIn($procesaMensajeGenericoT241 as element(ns2:procesaMensajeGenericoT24),
    $sourceBank as xs:string,
    $destinationBank as xs:string)
    as element(ns0:FPCWithdrawalConsultation) {   	
        <ns0:FPCWithdrawalConsultation>
            <GeneralInfo>
                <SourceBank>{ $sourceBank }</SourceBank>
                <DestinationBank>{ $destinationBank }</DestinationBank>
                <Language>es</Language>
            </GeneralInfo>
            {
	            let $messageList := fn:tokenize(data($procesaMensajeGenericoT241/MESSAGE),"@FM")
	            return (
		            <RequestNumber>{ $messageList[2] }</RequestNumber>,
		            <ClientId>{ $messageList[1] }</ClientId>
		        )
	        }
        </ns0:FPCWithdrawalConsultation>
};

declare variable $procesaMensajeGenericoT241 as element(ns2:procesaMensajeGenericoT24) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;

xf:consultaRetiroFPC12cIn($procesaMensajeGenericoT241,
    $sourceBank,
    $destinationBank)