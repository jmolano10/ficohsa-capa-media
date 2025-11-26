(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/solcitudChequeras/xsd/solicitudChequeras_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/solicitudChequeras";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudChequeras/xq/solicitudChequerasPAHeaderOut/";

declare function xf:solicitudChequerasPAHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
           if (fn:string($outputParameters/ns0:PV_ERROR_CODE/text()) = "SUCCESS") then (
                    <successIndicator>Success</successIndicator>
               )
           else( 
        	   <successIndicator> {data($outputParameters/ns0:PV_ERROR_CODE)}</successIndicator>, 
               <messages> {data($outputParameters/ns0:PV_ERROR_MESSAGE)} </messages>
           )
        }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:solicitudChequerasPAHeaderOut($outputParameters)