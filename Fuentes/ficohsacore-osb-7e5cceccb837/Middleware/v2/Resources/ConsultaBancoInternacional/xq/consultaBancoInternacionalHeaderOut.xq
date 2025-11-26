(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/INTFC/consultaBancoInternacional/xsd/consultaBancoInternacional_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaBancoInternacional";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBancoInternacional/xq/consultaBancoInternacionalHeaderOut/";

declare function xf:consultaBancoInternacionalHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
           if (fn:string($outputParameters/ns1:PV_CODIGOMENSAJE/text()) = "SUCCESS") then (
                    <successIndicator>Success</successIndicator>
               )
           else( 
        	   <successIndicator> {data($outputParameters/ns1:PV_CODIGOMENSAJE)}</successIndicator>, 
               <messages> {data($outputParameters/ns1:PV_DESCRIPCIONMENSAJE)} </messages>
           )
        }

        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaBancoInternacionalHeaderOut($outputParameters)