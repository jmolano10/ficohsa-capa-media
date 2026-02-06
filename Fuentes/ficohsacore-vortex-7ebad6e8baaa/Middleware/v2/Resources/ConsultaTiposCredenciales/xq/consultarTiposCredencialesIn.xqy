xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTiposCredenciales" element="ns0:consultaTiposCredenciales" location="../../AutenticacionClienteTarjeta/xsd/autenticacionClienteTarjetaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DIGITARCLI/consultaTiposCredenciales/xsd/consultarTiposCredencialesStepUp_db.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autenticacionClienteTarjetaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/DIGITARCLI/OSB_K_VCAS/STEP_UP/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposCredenciales/xq/consultarTiposCredencialesIn/";

declare function xf:consultarTiposCredencialesStepUpIn($consultaTiposCredenciales as element(ns0:consultaTiposCredenciales))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_PROCESSORID>{ data($consultaTiposCredenciales/PROCESSORID) }</ns1:PV_PROCESSORID>
            <ns1:PV_ISSUERID>{ data($consultaTiposCredenciales/ISSUERID) }</ns1:PV_ISSUERID>
            <ns1:PV_TRANSACTIONID>{ data($consultaTiposCredenciales/TRANSACTIONID) }</ns1:PV_TRANSACTIONID>
            <ns1:PV_DSTRANSACTIONID>{ data($consultaTiposCredenciales/DSTRANSACTIONID) }</ns1:PV_DSTRANSACTIONID>
            <ns1:PV_STEPUPREQUESTID>{ data($consultaTiposCredenciales/STEPUPREQUESTID) }</ns1:PV_STEPUPREQUESTID>
            <ns1:PN_STEPUPCOUNTER>{ data($consultaTiposCredenciales/STEPUPCOUNTER) }</ns1:PN_STEPUPCOUNTER>
            <ns1:PV_DEVICELOCALE>{ data($consultaTiposCredenciales/DEVICELOCALE) }</ns1:PV_DEVICELOCALE>
            <ns1:PV_DEVICEUSERAGENT>{ data($consultaTiposCredenciales/DEVICEUSERAGENT) }</ns1:PV_DEVICEUSERAGENT>
            <ns1:PV_MESSAGEVERSION>{ data($consultaTiposCredenciales/MESSAGEVERSION) }</ns1:PV_MESSAGEVERSION>
            <ns1:PV_RDXMESSAGEVERSION>{ data($consultaTiposCredenciales/RDXMESSAGEVERSION) }</ns1:PV_RDXMESSAGEVERSION>
            <ns1:PV_STEPUPREASON>{ data($consultaTiposCredenciales/STEPUPREASON) }</ns1:PV_STEPUPREASON>
            <ns1:PT_MERCHANTINFO>
                <ns1:PT_MERCHANTINFO_ITEM>
                    <ns1:ACQUIRERID>{ data($consultaTiposCredenciales/MERCHANTINFO/ACQUIRERID) }</ns1:ACQUIRERID>
                    <ns1:ACQUIRERCOUNTRYCODE>{ data($consultaTiposCredenciales/MERCHANTINFO/ACQUIRERCOUNTRYCODE) }</ns1:ACQUIRERCOUNTRYCODE>
                    <ns1:MERCHANTID>{ data($consultaTiposCredenciales/MERCHANTINFO/MERCHANTID) }</ns1:MERCHANTID>
                    <ns1:MERCHANTNAME>{ data($consultaTiposCredenciales/MERCHANTINFO/MERCHANTNAME) }</ns1:MERCHANTNAME>
                    <ns1:MERCHANTURL>{ data($consultaTiposCredenciales/MERCHANTINFO/MERCHANTURL) }</ns1:MERCHANTURL>
                    <ns1:MERCHANTCATEGORYCODE>{ data($consultaTiposCredenciales/MERCHANTINFO/MERCHANTCATEGORYCODE) }</ns1:MERCHANTCATEGORYCODE>
                    <ns1:MERCHANTCOUNTRYCODE>{ data($consultaTiposCredenciales/MERCHANTINFO/MERCHANTCOUNTRYCODE) }</ns1:MERCHANTCOUNTRYCODE>
                </ns1:PT_MERCHANTINFO_ITEM>
            </ns1:PT_MERCHANTINFO>
            <ns1:PT_PAYMENTINFO>
                <ns1:PT_PAYMENTINFO_ITEM>
                    <ns1:CARDNUMBER>{ data($consultaTiposCredenciales/PAYMENTINFO/CARDNUMBER) }</ns1:CARDNUMBER>
                    <ns1:CARDEXPIRYMONTH>{ data($consultaTiposCredenciales/PAYMENTINFO/CARDEXPIRYMONTH) }</ns1:CARDEXPIRYMONTH>
                    <ns1:CARDEXPIRYYEAR>{ data($consultaTiposCredenciales/PAYMENTINFO/CARDEXPIRYYEAR) }</ns1:CARDEXPIRYYEAR>
                    <ns1:CARDTYPE>{ data($consultaTiposCredenciales/PAYMENTINFO/CARDTYPE) }</ns1:CARDTYPE>
                    <ns1:CARDHOLDERNAME>{ data($consultaTiposCredenciales/PAYMENTINFO/CARDHOLDERNAME) }</ns1:CARDHOLDERNAME>
                </ns1:PT_PAYMENTINFO_ITEM>
            </ns1:PT_PAYMENTINFO>
            <ns1:PT_TRANSACTIONINFO>
                <ns1:PT_TRANSACTIONINFO_ITEM>
                    <ns1:TRANSACTIONTIMESTAMP>{ data($consultaTiposCredenciales/TRANSACTIONINFO/TRANSACTIONTIMESTAMP) }</ns1:TRANSACTIONTIMESTAMP>
                    <ns1:TRANSACTIONAMOUNT>{ data($consultaTiposCredenciales/TRANSACTIONINFO/TRANSACTIONAMOUNT) }</ns1:TRANSACTIONAMOUNT>
                    <ns1:TRANSACTIONCURRENCY>{ data($consultaTiposCredenciales/TRANSACTIONINFO/TRANSACTIONCURRENCY) }</ns1:TRANSACTIONCURRENCY>
                    <ns1:TRANSACTIONEXPONENT>{ data($consultaTiposCredenciales/TRANSACTIONINFO/TRANSACTIONEXPONENT) }</ns1:TRANSACTIONEXPONENT>
                    <ns1:TRANSACTIONTYPE>{ data($consultaTiposCredenciales/TRANSACTIONINFO/TRANSACTIONTYPE) }</ns1:TRANSACTIONTYPE>
                    <ns1:MANDATEDREGION>{ data($consultaTiposCredenciales/TRANSACTIONINFO/MANDATEDREGION) }</ns1:MANDATEDREGION>
                    <ns1:CHANNEL>{ data($consultaTiposCredenciales/TRANSACTIONINFO/CHANNEL) }</ns1:CHANNEL>
                </ns1:PT_TRANSACTIONINFO_ITEM>
            </ns1:PT_TRANSACTIONINFO>
            <ns1:PT_CARDHOLDERSELECTIONINFO>
                <ns1:PT_CARDHOLDERSELECTIONINFO_ITEM>
                    <ns1:TYPE>{ data($consultaTiposCredenciales/CARDHOLDERSELECTIONINFO/TYPE) }</ns1:TYPE>
                    <ns1:NAME>{ data($consultaTiposCredenciales/CARDHOLDERSELECTIONINFO/NAME) }</ns1:NAME>
                </ns1:PT_CARDHOLDERSELECTIONINFO_ITEM>
            </ns1:PT_CARDHOLDERSELECTIONINFO>
        </ns1:InputParameters>
};

declare variable $consultaTiposCredenciales as element(ns0:consultaTiposCredenciales) external;

xf:consultarTiposCredencialesStepUpIn($consultaTiposCredenciales)