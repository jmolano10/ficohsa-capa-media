xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$envioVerificacionToken" element="ns1:envioVerificacionToken" location="../../AutenticacionClienteTarjeta/xsd/autenticacionClienteTarjetaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DIGITARCLI/envioVerificacionToken/xsd/enviarVerificacionTokenInitiateAction_db.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autenticacionClienteTarjetaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/DIGITARCLI/OSB_K_VCAS/INITIATE_ACTION/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioVerificacionToken/xq/enviarVerificacionTokenIn/";

declare function xf:enviarVerificacionTokenInitiateActionIn($envioVerificacionToken as element(ns1:envioVerificacionToken))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_PROCESSORID>{ data($envioVerificacionToken/PROCESSORID) }</ns0:PV_PROCESSORID>
            <ns0:PV_ISSUERID>{ data($envioVerificacionToken/ISSUERID) }</ns0:PV_ISSUERID>
            <ns0:PV_TRANSACTIONID>{ data($envioVerificacionToken/TRANSACTIONID) }</ns0:PV_TRANSACTIONID>
            <ns0:PV_DSTRANSACTIONID>{ data($envioVerificacionToken/DSTRANSACTIONID) }</ns0:PV_DSTRANSACTIONID>
            <ns0:PV_STEPUPREQUESTID>{ data($envioVerificacionToken/STEPUPREQUESTID) }</ns0:PV_STEPUPREQUESTID>
            <ns0:PV_STEPUPTYPE>{ data($envioVerificacionToken/STEPUPTYPE) }</ns0:PV_STEPUPTYPE>
            <ns0:PN_STEPUPCOUNTER>{ data($envioVerificacionToken/STEPUPCOUNTER) }</ns0:PN_STEPUPCOUNTER>
            <ns0:PV_OTPREFERENCECODE>{ data($envioVerificacionToken/OTPREFERENCECODE) }</ns0:PV_OTPREFERENCECODE>
            <ns0:PV_VERIFICATIONTOKEN>{ data($envioVerificacionToken/VERIFICATIONTOKEN) }</ns0:PV_VERIFICATIONTOKEN>
            <ns0:PV_MESSAGEVERSION>{ data($envioVerificacionToken/MESSAGEVERSION) }</ns0:PV_MESSAGEVERSION>
            <ns0:PV_RDXMESSAGEVERSION>{ data($envioVerificacionToken/RDXMESSAGEVERSION) }</ns0:PV_RDXMESSAGEVERSION>
            {
                let $CREDENTIALS := $envioVerificacionToken/CREDENTIALS
                return
                    <ns0:PT_CREDENTIALS>
                        {
                            for $CREDENTIAL in $CREDENTIALS/CREDENTIAL
                            return
                                <ns0:PT_CREDENTIALS_ITEM>
                                    <ns0:CREDENTIAL>
                                        <ns0:ID>{ data($CREDENTIAL/ID) }</ns0:ID>
                                        <ns0:TYPE>{ data($CREDENTIAL/TYPE) }</ns0:TYPE>
                                        {
                                            for $TEXT in $CREDENTIAL/TEXT
                                            return
                                                <ns0:TEXT>{ data($TEXT) }</ns0:TEXT>
                                        }
                                    </ns0:CREDENTIAL>
                                </ns0:PT_CREDENTIALS_ITEM>
                        }
                    </ns0:PT_CREDENTIALS>
            }
            <ns0:PT_MERCHANTINFO>
                <ns0:PT_MERCHANTINFO_ITEM>
                    <ns0:ACQUIRERID>{ data($envioVerificacionToken/MERCHANTINFO/ACQUIRERID) }</ns0:ACQUIRERID>
                    <ns0:ACQUIRERCOUNTRYCODE>{ data($envioVerificacionToken/MERCHANTINFO/ACQUIRERCOUNTRYCODE) }</ns0:ACQUIRERCOUNTRYCODE>
                    <ns0:MERCHANTID>{ data($envioVerificacionToken/MERCHANTINFO/MERCHANTID) }</ns0:MERCHANTID>
                    <ns0:MERCHANTNAME>{ data($envioVerificacionToken/MERCHANTINFO/MERCHANTNAME) }</ns0:MERCHANTNAME>
                    <ns0:MERCHANTURL>{ data($envioVerificacionToken/MERCHANTINFO/MERCHANTURL) }</ns0:MERCHANTURL>
                    <ns0:MERCHANTCATEGORYCODE>{ data($envioVerificacionToken/MERCHANTINFO/MERCHANTCATEGORYCODE) }</ns0:MERCHANTCATEGORYCODE>
                    <ns0:MERCHANTCOUNTRYCODE>{ data($envioVerificacionToken/MERCHANTINFO/MERCHANTCOUNTRYCODE) }</ns0:MERCHANTCOUNTRYCODE>
                </ns0:PT_MERCHANTINFO_ITEM>
            </ns0:PT_MERCHANTINFO>
            <ns0:PT_PAYMENTINFO>
                <ns0:PT_PAYMENTINFO_ITEM>
                    <ns0:CARDNUMBER>{ data($envioVerificacionToken/PAYMENTINFO/CARDNUMBER) }</ns0:CARDNUMBER>
                    <ns0:CARDEXPIRYMONTH>{ data($envioVerificacionToken/PAYMENTINFO/CARDEXPIRYMONTH) }</ns0:CARDEXPIRYMONTH>
                    <ns0:CARDEXPIRYYEAR>{ data($envioVerificacionToken/PAYMENTINFO/CARDEXPIRYYEAR) }</ns0:CARDEXPIRYYEAR>
                    <ns0:CARDTYPE>{ data($envioVerificacionToken/PAYMENTINFO/CARDTYPE) }</ns0:CARDTYPE>
                    <ns0:CARDHOLDERNAME>{ data($envioVerificacionToken/PAYMENTINFO/CARDHOLDERNAME) }</ns0:CARDHOLDERNAME>
                </ns0:PT_PAYMENTINFO_ITEM>
            </ns0:PT_PAYMENTINFO>
            <ns0:PT_TRANSACTIONINFO>
                <ns0:PT_TRANSACTIONINFO_ITEM>
                    <ns0:TRANSACTIONTIMESTAMP>{ data($envioVerificacionToken/TRANSACTIONINFO/TRANSACTIONTIMESTAMP) }</ns0:TRANSACTIONTIMESTAMP>
                    <ns0:TRANSACTIONAMOUNT>{ data($envioVerificacionToken/TRANSACTIONINFO/TRANSACTIONAMOUNT) }</ns0:TRANSACTIONAMOUNT>
                    <ns0:TRANSACTIONCURRENCY>{ data($envioVerificacionToken/TRANSACTIONINFO/TRANSACTIONCURRENCY) }</ns0:TRANSACTIONCURRENCY>
                    <ns0:TRANSACTIONEXPONENT>{ data($envioVerificacionToken/TRANSACTIONINFO/TRANSACTIONEXPONENT) }</ns0:TRANSACTIONEXPONENT>
                    <ns0:TRANSACTIONTYPE>{ data($envioVerificacionToken/TRANSACTIONINFO/TRANSACTIONTYPE) }</ns0:TRANSACTIONTYPE>
                    <ns0:MANDATEDREGION>{ data($envioVerificacionToken/TRANSACTIONINFO/MANDATEDREGION) }</ns0:MANDATEDREGION>
                    <ns0:CHANNEL>{ data($envioVerificacionToken/TRANSACTIONINFO/CHANNEL) }</ns0:CHANNEL>
                </ns0:PT_TRANSACTIONINFO_ITEM>
            </ns0:PT_TRANSACTIONINFO>
        </ns0:InputParameters>
};

declare variable $envioVerificacionToken as element(ns1:envioVerificacionToken) external;

xf:enviarVerificacionTokenInitiateActionIn($envioVerificacionToken)