xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagodetarjetaCreditoResponse" element="ns0:PagoTarjetaCreditoV4Response" location="../../../BusinessServices/T24/svcPayCreditCardFT/XMLSchema_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoHNOut1/";

declare function xf:pagoTarjetaCreditoHNOut1($pagodetarjetaCreditoResponse as element(ns0:PagoTarjetaCreditoV4Response))
    as element(ns1:pagoTarjetaCreditoResponse) {
          let $FUNDSTRANSFERType := $pagodetarjetaCreditoResponse/FUNDSTRANSFERType
        return
        if(exists($FUNDSTRANSFERType)) then (
            <ns1:pagoTarjetaCreditoResponse>
                  <LCY_PAYMENT>{ data($pagodetarjetaCreditoResponse/FUNDSTRANSFERType/DEBITAMOUNT) }</LCY_PAYMENT>
                  <PAYMENT_CURRENCY>{ data($pagodetarjetaCreditoResponse/FUNDSTRANSFERType/DEBITCURRENCY) }</PAYMENT_CURRENCY>
                  <BALANCE_PAYMENT>{data($pagodetarjetaCreditoResponse/FUNDSTRANSFERType/LROTHAMT) }</BALANCE_PAYMENT>
                  <BALANCE_CURRENCY>{ data($pagodetarjetaCreditoResponse/FUNDSTRANSFERType/LRCRCCY) }</BALANCE_CURRENCY>
                  <EXCHANGE_RATE>{ data($pagodetarjetaCreditoResponse/FUNDSTRANSFERType/LRCUSTRATE) }</EXCHANGE_RATE>
                  <DEBIT_ACCOUNT>{data($pagodetarjetaCreditoResponse/FUNDSTRANSFERType/DEBITACCTNO) }</DEBIT_ACCOUNT>
                  <DATE_TIME>{ concat("20",data($pagodetarjetaCreditoResponse/FUNDSTRANSFERType/gDATETIME/DATETIME[1])) }</DATE_TIME>
            </ns1:pagoTarjetaCreditoResponse>
         )else (
            <ns1:pagoTarjetaCreditoResponse/>
		 )
};

                    

declare variable $pagodetarjetaCreditoResponse as element(ns0:PagoTarjetaCreditoV4Response) external;

xf:pagoTarjetaCreditoHNOut1($pagodetarjetaCreditoResponse)