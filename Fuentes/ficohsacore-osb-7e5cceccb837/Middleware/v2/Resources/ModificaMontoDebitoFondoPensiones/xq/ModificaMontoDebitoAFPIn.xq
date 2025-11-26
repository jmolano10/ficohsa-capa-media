(:: pragma bea:global-element-parameter parameter="$modificaMontoDebitoFondoPensionesRequest" element="ns0:modificaMontoDebitoFondoPensionesRequest" location="../xsd/modificaMontoDebitoFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaMontoDebitoAFP/xsd/ModificaMontoDebitoAFP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ModificaMontoDebitoAFP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/modificaMontoDebitoFondoPensionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaMontoDebitoFondoPensiones/xq/ModificaMontoDebitoAFPIn/";

declare function xf:ModificaMontoDebitoAFPIn($modificaMontoDebitoFondoPensionesRequest as element(ns0:modificaMontoDebitoFondoPensionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>        
           
            <ns1:PV_CODIGO_DEUDOR>{ data($modificaMontoDebitoFondoPensionesRequest/ID) }</ns1:PV_CODIGO_DEUDOR>
            <ns1:PN_MONTO>{ fn:number($modificaMontoDebitoFondoPensionesRequest/AMOUNT) }</ns1:PN_MONTO>
             
        </ns1:InputParameters>
};

declare variable $modificaMontoDebitoFondoPensionesRequest as element(ns0:modificaMontoDebitoFondoPensionesRequest) external;

xf:ModificaMontoDebitoAFPIn($modificaMontoDebitoFondoPensionesRequest)