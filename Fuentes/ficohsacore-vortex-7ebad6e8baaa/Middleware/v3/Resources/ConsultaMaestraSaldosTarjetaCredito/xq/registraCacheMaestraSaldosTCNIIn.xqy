xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldosTarjetaCreditoResponse" element="ns0:consultaMaestraSaldosTarjetaCreditoResponse" location="../xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraMaestraSaldosTC/xsd/registraMaestraSaldosTC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraMaestraSaldosTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/registraCacheMaestraSaldosTCNIIn/";

declare function xf:registraCacheMaestraSaldosTCNIIn($consultaMaestraSaldosTarjetaCreditoResponse as element(ns0:consultaMaestraSaldosTarjetaCreditoResponse),
    $PV_CODIGO_PAIS as xs:string,
    $CARD_NUMBER as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_PAIS>{ $PV_CODIGO_PAIS }</ns1:PV_CODIGO_PAIS>
            <ns1:PT_MAESTRA_SALDOS_TC>
                <ns1:PT_MAESTRA_SALDOS_TC_ITEM>
                    <ns1:CARD_NUMBER>{ $CARD_NUMBER }</ns1:CARD_NUMBER>
                    {
                        for $INSTITUTION_ID in $consultaMaestraSaldosTarjetaCreditoResponse/INSTITUTION_ID
                        return
                            <ns1:INSTITUTION_ID>{ data($INSTITUTION_ID) }</ns1:INSTITUTION_ID>
                    }
                    {
                        for $COUNTRY_CODE in $consultaMaestraSaldosTarjetaCreditoResponse/COUNTRY_CODE
                        return
                            <ns1:COUNTRY_CODE>{ data($COUNTRY_CODE) }</ns1:COUNTRY_CODE>
                    }
                    {
                        for $CARD_HOLDER_NAME in $consultaMaestraSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME
                        return
                            <ns1:CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</ns1:CARD_HOLDER_NAME>
                    }
                    {
                        for $BIRTHDATE in $consultaMaestraSaldosTarjetaCreditoResponse/BIRTHDATE
                        return
                            <ns1:BIRTHDATE>{ data($BIRTHDATE) }</ns1:BIRTHDATE>
                    }
                    {
                        for $PRODUCT_TYPE_CODE in $consultaMaestraSaldosTarjetaCreditoResponse/PRODUCT_TYPE_CODE
                        return
                            <ns1:PRODUCT_TYPE_CODE>{ data($PRODUCT_TYPE_CODE) }</ns1:PRODUCT_TYPE_CODE>
                    }
                    {
                        for $REGISTERED_SIGNATURES in $consultaMaestraSaldosTarjetaCreditoResponse/REGISTERED_SIGNATURES
                        return
                            <ns1:REGISTERED_SIGNATURES>{ data($REGISTERED_SIGNATURES) }</ns1:REGISTERED_SIGNATURES>
                    }
                    {
                        for $LOGO in $consultaMaestraSaldosTarjetaCreditoResponse/LOGO
                        return
                            <ns1:LOGO>{ data($LOGO) }</ns1:LOGO>
                    }
                    {
                        for $BLOCK_CODE in $consultaMaestraSaldosTarjetaCreditoResponse/BLOCK_CODE
                        return
                            <ns1:BLOCK_CODE>{ data($BLOCK_CODE) }</ns1:BLOCK_CODE>
                    }
                    {
                        for $ACTIVE_IDENTIFIER in $consultaMaestraSaldosTarjetaCreditoResponse/ACTIVE_IDENTIFIER
                        return
                            <ns1:ACTIVE_IDENTIFIER>{ data($ACTIVE_IDENTIFIER) }</ns1:ACTIVE_IDENTIFIER>
                    }
                    {
                        for $CARD_HOLDER_TYPE in $consultaMaestraSaldosTarjetaCreditoResponse/CARD_HOLDER_TYPE
                        return
                            <ns1:CARD_HOLDER_TYPE>{ data($CARD_HOLDER_TYPE) }</ns1:CARD_HOLDER_TYPE>
                    }
                    {
                        for $MAX_PAYMENT_DATE in $consultaMaestraSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
                        return
                            <ns1:MAX_PAYMENT_DATE>{ data($MAX_PAYMENT_DATE) }</ns1:MAX_PAYMENT_DATE>
                    }
                    {
                        for $CUTOFF_DATE in $consultaMaestraSaldosTarjetaCreditoResponse/CUTOFF_DATE
                        return
                            <ns1:CUTOFF_DATE>{ data($CUTOFF_DATE) }</ns1:CUTOFF_DATE>
                    }
                    {
                        let $result :=
                            for $CREDIT_CARD_BALANCE_INFO in $consultaMaestraSaldosTarjetaCreditoResponse/CREDIT_CARD_BALANCE_INFO
                            return
                                concat(fn-bea:serialize($CREDIT_CARD_BALANCE_INFO))
                        return
                            
                            
                        <ns1:CREDIT_CARD_BALANCE_INFO>{ $result }</ns1:CREDIT_CARD_BALANCE_INFO>
                    }
                    {
                        for $CREDIT_CARD_POINTS_INFO in $consultaMaestraSaldosTarjetaCreditoResponse/CREDIT_CARD_POINTS_INFO
                        return
                            <ns1:CREDIT_CARD_POINTS_INFO>{ fn-bea:serialize($CREDIT_CARD_POINTS_INFO) }</ns1:CREDIT_CARD_POINTS_INFO>
                    }
                    {
                        for $TOTAL_PAYMENT in $consultaMaestraSaldosTarjetaCreditoResponse/TOTAL_PAYMENT
                        return
                            <ns1:TOTAL_PAYMENT>{ data($TOTAL_PAYMENT) }</ns1:TOTAL_PAYMENT>
                    }
                </ns1:PT_MAESTRA_SALDOS_TC_ITEM>
            </ns1:PT_MAESTRA_SALDOS_TC>
        </ns1:InputParameters>
};

declare variable $consultaMaestraSaldosTarjetaCreditoResponse as element(ns0:consultaMaestraSaldosTarjetaCreditoResponse) external;
declare variable $PV_CODIGO_PAIS as xs:string external;
declare variable $CARD_NUMBER as xs:string external;

xf:registraCacheMaestraSaldosTCNIIn($consultaMaestraSaldosTarjetaCreditoResponse,
    $PV_CODIGO_PAIS,
    $CARD_NUMBER)