xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$fPCWithdrawalConsultationResponse1" element="ns0:FPCWithdrawalConsultationResponse" location="../../../BusinessServices/ConsultaRetiroFPC/Resources/v1.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaRetiroFPC12cHeaderOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";

declare function xf:consultaRetiroFPC12cHeaderOut($fPCWithdrawalConsultationResponse1 as element(ns0:FPCWithdrawalConsultationResponse))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            <successIndicator>
                    { 
                    	if (data($fPCWithdrawalConsultationResponse1/StatusInfo/Status)  = 'Success') then (
	                    	"SUCCESS"
	                	) else (
	                		"ERROR"
	                	)
                    }
            </successIndicator>
            <messages>
                {
                    let $status  := upper-case($fPCWithdrawalConsultationResponse1/StatusInfo/Status)  
                    return
                        (concat(if($status ='SUCCESS')then(0)else($status) ,'|',if($status ='SUCCESS')then('OK')else("Error - Solicitud no disponible100")))
                }
            </messages>
        </ns2:ResponseHeader>
};

declare variable $fPCWithdrawalConsultationResponse1 as element(ns0:FPCWithdrawalConsultationResponse) external;

xf:consultaRetiroFPC12cHeaderOut($fPCWithdrawalConsultationResponse1)