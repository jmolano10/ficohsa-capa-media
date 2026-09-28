(:: pragma bea:global-element-parameter parameter="$consultaCancelacionAnticipadaFinanciamiento" element="ns0:consultaCancelacionAnticipadaFinanciamiento" location="../xsd/consultaCancelacionAnticipadaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada" location="../../../../External/Outgoing/BusinessServices/Salesforce/consultaCancelacionAnticipadaFinanciamiento/wsdl/consultaCancelacionAnticipadaFinanciamiento.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCancelacionAnticipadaFinanciamientoTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/External/Outgoing/BusinessServices/Salesforce/consultaCancelacionAnticipadaFinanciamiento/consultaCancelacionAnticipadaFinanciamientoIn/";

declare function xf:consultaCancelacionAnticipadaFinanciamientoIn($consultaCancelacionAnticipadaFinanciamiento as element(ns0:consultaCancelacionAnticipadaFinanciamiento))
    as element(ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada) {
        <ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada>
            <ns1:numeroCuenta>{ data($consultaCancelacionAnticipadaFinanciamiento/CREDIT_CARD_ACCOUNT_NUMBER) }</ns1:numeroCuenta>
        </ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada>
};

declare variable $consultaCancelacionAnticipadaFinanciamiento as element(ns0:consultaCancelacionAnticipadaFinanciamiento) external;

xf:consultaCancelacionAnticipadaFinanciamientoIn($consultaCancelacionAnticipadaFinanciamiento)