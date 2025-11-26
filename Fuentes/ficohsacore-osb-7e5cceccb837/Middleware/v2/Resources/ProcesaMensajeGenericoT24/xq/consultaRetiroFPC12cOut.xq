(:: pragma bea:global-element-parameter parameter="$fPCWithdrawalConsultationResponse1" element="ns0:FPCWithdrawalConsultationResponse" location="../../../BusinessServices/ConsultaRetiroFPC/Resources/v1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns2 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaRetiroFPC112cOut/";

declare function xf:consultaRetiroFPC112cOut($transactionId as xs:string,
    $sessionId as xs:string,
    $fPCWithdrawalConsultationResponse1 as element(ns0:FPCWithdrawalConsultationResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>
                {
                    let $status  := upper-case($fPCWithdrawalConsultationResponse1/StatusInfo/Status)  
                    return
                        (concat(if($status ='SUCCESS')then(0)else($status) ,'|',if($status ='SUCCESS')then('OK')else($fPCWithdrawalConsultationResponse1/ErrorInfo/Description), '|' , $fPCWithdrawalConsultationResponse1/Account , '|' , $fPCWithdrawalConsultationResponse1/ClientName , '|' , $fPCWithdrawalConsultationResponse1/IdNumber , '|' , $fPCWithdrawalConsultationResponse1/PaymentMethod , '|' , $fPCWithdrawalConsultationResponse1/Currency , '|' , $fPCWithdrawalConsultationResponse1/Amount , '|' , $fPCWithdrawalConsultationResponse1/WithdrawalType , '|' , $fPCWithdrawalConsultationResponse1/BankingAccount))
                }
</MESSAGE>
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $fPCWithdrawalConsultationResponse1 as element(ns0:FPCWithdrawalConsultationResponse) external;

xf:consultaRetiroFPC112cOut($transactionId,
    $sessionId,
    $fPCWithdrawalConsultationResponse1)
