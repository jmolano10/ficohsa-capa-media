xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/PaymentRecordCreditCard";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/paymentRecordCreditCardTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetParameter";
(:: import schema at "../../../../../ProviderServices/XSD/GetParameter/GetParameter_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/PaymentRecordCreditCard";
(:: import schema at "../../../../../ProviderServices/XSD/PaymentRecordCreditCard/PaymentRecordCreditCard_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $PaymentRecordCreditCardRequest as element() (:: schema-element(ns1:PaymentRecordCreditCardRequest) ::) external;
declare variable $GetParameterResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $paymentType as xs:string external;
declare variable $ORG as xs:string external;
declare variable $merchantDefault as xs:string external;
declare variable $merchant as xs:string external;
declare variable $channelDefault as xs:string external;
declare variable $channel as xs:string external;
declare variable $userName as xs:string external;

declare function local:func($PaymentRecordCreditCardRequest as element() (:: schema-element(ns1:PaymentRecordCreditCardRequest) ::), 
                            $GetParameterResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $paymentType as xs:string, 
                            $ORG as xs:string, 
                            $merchantDefault as xs:string, 
                            $merchant as xs:string, 
                            $channelDefault as xs:string, 
                            $channel as xs:string, 
                            $userName as xs:string) 
                            as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            if (fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$merchant]/ns2:VALUE)!='')
            then <ns3:PV_MERCHANTNUMBER>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$merchant]/ns2:VALUE)}</ns3:PV_MERCHANTNUMBER>
            else (<ns3:PV_MERCHANTNUMBER>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$merchantDefault]/ns2:VALUE)}</ns3:PV_MERCHANTNUMBER>)
        }
        <ns3:PV_NUMEROTARJETA>{fn:data($PaymentRecordCreditCardRequest/ns1:CreditCard)}</ns3:PV_NUMEROTARJETA>
        <ns3:PV_TIPOOPERACION>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME='FICBCO0067.HN01.REVERSE']/ns2:VALUE)}</ns3:PV_TIPOOPERACION>
        {
            if(fn:data($PaymentRecordCreditCardRequest/ns1:Currency)= 'HNL')
            then <ns3:PN_TIPOMONEDA>1</ns3:PN_TIPOMONEDA>
            else(<ns3:PN_TIPOMONEDA>2</ns3:PN_TIPOMONEDA>)
        }

        <ns3:PN_ORGANIZACION>{fn:data($ORG)}</ns3:PN_ORGANIZACION>
        <ns3:PV_MONEDATRANSACCION>{fn:data($PaymentRecordCreditCardRequest/ns1:Currency)}</ns3:PV_MONEDATRANSACCION>
        <ns3:PN_TASACAMBIO>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME='FICBCO0067.HN01.RATE']/ns2:VALUE)}</ns3:PN_TASACAMBIO>
        <ns3:PN_TIPOTRANSACCION>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$paymentType]/ns2:VALUE)}</ns3:PN_TIPOTRANSACCION>
        <ns3:PV_CODIGOUSUARIO>{fn:data($userName)}</ns3:PV_CODIGOUSUARIO>
        <ns3:PN_VALOREFECTIVO>{fn:data($PaymentRecordCreditCardRequest/ns1:PaymentAmount)}</ns3:PN_VALOREFECTIVO>
        {
            if ($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:SourceBank)
            then <ns3:PV_BANCOORIGEN>{fn:data($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:SourceBank)}</ns3:PV_BANCOORIGEN>
            else ()
        }
        {
            if ($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:DestinationBank)
            then <ns3:PV_BANCODESTINO>{fn:data($PaymentRecordCreditCardRequest/ns1:GeneralInfo/com:DestinationBank)}</ns3:PV_BANCODESTINO>
            else ()
        }
        <ns3:PV_DESCRIPCIONTRANSACCION>{fn:data($PaymentRecordCreditCardRequest/ns1:Description)}</ns3:PV_DESCRIPCIONTRANSACCION>
        {
            if (fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$channel]/ns2:VALUE)!='')
            then <ns3:PV_CANAL>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$channel]/ns2:VALUE)}</ns3:PV_CANAL>
            else (<ns3:PV_CANAL>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$channelDefault]/ns2:VALUE)}</ns3:PV_CANAL>)
        }
        <ns3:PV_APLICADO>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME='FICBCO0067.HN01.APPLIED']/ns2:VALUE)}</ns3:PV_APLICADO>
        <ns3:PV_APLICARENLINEA>{fn:data($GetParameterResponse/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME='FICBCO0067.HN01.APPLIED.ONLINE']/ns2:VALUE)}</ns3:PV_APLICARENLINEA>
    </ns3:InputParameters>
};

local:func($PaymentRecordCreditCardRequest, $GetParameterResponse, $paymentType, $ORG, $merchantDefault, $merchant, $channelDefault, $channel, $userName)