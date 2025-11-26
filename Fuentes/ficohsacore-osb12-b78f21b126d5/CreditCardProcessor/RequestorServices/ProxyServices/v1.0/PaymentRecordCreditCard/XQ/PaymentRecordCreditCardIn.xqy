xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/PaymentRecordCreditCard";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/paymentRecordCreditCardTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetParameter";
(:: import schema at "../../../../../ProviderServices/XSD/GetParameter/GetParameter_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/OsbConOrgSequence";
(:: import schema at "../../../../../ProviderServices/XSD/OsbConOrgSequence/OsbConOrgSequence_sp.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/PaymentRecordCreditCard";
(:: import schema at "../../../../../ProviderServices/XSD/PaymentRecordCreditCard/PaymentRecordCreditCard_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $PaymentRecordCreditCardRequest as element() (:: schema-element(ns1:PaymentRecordCreditCardRequest) ::) external;
declare variable $OsbConOrgSequenceResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $GetParameterResponse as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $paymentType as xs:string external;
declare variable $merchantDefault as xs:string external;
declare variable $merchant as xs:string external;
declare variable $channel as xs:string external;
declare variable $channelDefault as xs:string external;
declare variable $userName as xs:string external;
declare variable $authorizationCode as xs:string external;

declare function local:func($PaymentRecordCreditCardRequest as element() (:: schema-element(ns1:PaymentRecordCreditCardRequest) ::), 
                            $OsbConOrgSequenceResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $GetParameterResponse as element() (:: schema-element(ns3:OutputParameters) ::), 
                            $paymentType as xs:string, 
                            $merchantDefault as xs:string, 
                            $merchant as xs:string, 
                            $channel as xs:string, 
                            $channelDefault as xs:string, 
                            $userName as xs:string, 
                            $authorizationCode as xs:string) 
                            as element() (:: schema-element(ns4:InputParameters) ::) {
    <ns4:InputParameters>
        {
            if (fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME=$merchant]/ns3:VALUE)!='')
            then <ns4:PV_MERCHANTNUMBER>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME=$merchant]/ns3:VALUE)}</ns4:PV_MERCHANTNUMBER>
            else (<ns4:PV_MERCHANTNUMBER>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME=$merchantDefault]/ns3:VALUE)}</ns4:PV_MERCHANTNUMBER>)
        }
        <ns4:PV_NUMEROTARJETA>{fn:data($PaymentRecordCreditCardRequest/ns1:CreditCard)}</ns4:PV_NUMEROTARJETA>
        <ns4:PV_TIPOOPERACION>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME='FICBCO0067.HN01.BUY']/ns3:VALUE)}</ns4:PV_TIPOOPERACION>
        {
            if(fn:data($PaymentRecordCreditCardRequest/ns1:Currency)='HNL')
            then <ns4:PN_TIPOMONEDA>1</ns4:PN_TIPOMONEDA>
            else(<ns4:PN_TIPOMONEDA>2</ns4:PN_TIPOMONEDA>)
        }
        <ns4:PN_ORGANIZACION>{fn:data($OsbConOrgSequenceResponse/ns2:ORG)}</ns4:PN_ORGANIZACION>
        <ns4:PV_MONEDATRANSACCION>{fn:data($PaymentRecordCreditCardRequest/ns1:Currency)}</ns4:PV_MONEDATRANSACCION>
        <ns4:PN_TASACAMBIO>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME='FICBCO0067.HN01.RATE']/ns3:VALUE)}</ns4:PN_TASACAMBIO>
        <ns4:PN_TIPOTRANSACCION>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME=$paymentType]/ns3:VALUE)}</ns4:PN_TIPOTRANSACCION>
        <ns4:PV_CODIGOUSUARIO>{fn:data($userName)}</ns4:PV_CODIGOUSUARIO>
        <ns4:PN_VALOREFECTIVO>{fn:data($PaymentRecordCreditCardRequest/ns1:PaymentAmount)}</ns4:PN_VALOREFECTIVO>
        {
            if ($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:SourceBank)
            then <ns4:PV_BANCOORIGEN>{fn:data($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:SourceBank)}</ns4:PV_BANCOORIGEN>
            else ()
        }
        {
            if ($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:DestinationBank)
            then <ns4:PV_BANCODESTINO>{fn:data($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:DestinationBank)}</ns4:PV_BANCODESTINO>
            else ()
        }
        <ns4:PV_DESCRIPCIONTRANSACCION>{fn:data($PaymentRecordCreditCardRequest/ns1:Description)}</ns4:PV_DESCRIPCIONTRANSACCION>
        {
            if (fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME=$channel]/ns3:VALUE)!='')
            then <ns4:PV_CANAL>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME=$channel]/ns3:VALUE)}</ns4:PV_CANAL>
            else (<ns4:PV_CANAL>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME=$channelDefault]/ns3:VALUE)}</ns4:PV_CANAL>)
        }
        <ns4:PV_NUMEROAUTORIZACION>{fn:data($authorizationCode)}</ns4:PV_NUMEROAUTORIZACION>
        <ns4:PV_APLICADO>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME='FICBCO0067.HN01.APPLIED']/ns3:VALUE)}</ns4:PV_APLICADO>
        <ns4:PV_APLICARENLINEA>{fn:data($GetParameterResponse/ns3:CONFIGURACIONES/ns3:CONFIGURACIONES_ITEM[ns3:NAME='FICBCO0067.HN01.APPLIED.ONLINE']/ns3:VALUE)}</ns4:PV_APLICARENLINEA>
    </ns4:InputParameters>
};

local:func($PaymentRecordCreditCardRequest, $OsbConOrgSequenceResponse, $GetParameterResponse, $paymentType, $merchantDefault, $merchant, $channel, $channelDefault, $userName, $authorizationCode)