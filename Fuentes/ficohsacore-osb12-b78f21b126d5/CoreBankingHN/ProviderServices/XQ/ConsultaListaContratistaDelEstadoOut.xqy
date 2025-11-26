xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../XSD/ConsultaListaContratistaDelEstado/XMLSchema_-2015926973.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasContratistaDelEstado";
(:: import schema at "../XSD/ConsultaListaContratistaDelEstado/ConsultaListaContratistaDelEstado_PS.xsd" ::)

declare variable $succesIndicator as xs:string external;
declare variable $ConsultaListaContratistaDelEstadoResponse as element() (:: schema-element(ns1:ConsultadeContratistasdelestadoResponse) ::) external;

declare function local:func($succesIndicator as xs:string, 
                            $ConsultaListaContratistaDelEstadoResponse as element() (:: schema-element(ns1:ConsultadeContratistasdelestadoResponse) ::)) 
                            as element() (:: schema-element(ns2:sjConsultaListasContratistaDelEstadoResponse) ::) {
    <ns2:sjConsultaListasClienteResponse>
        <ns2:consultaListaClienteResponse>
            <ns2:successIndicator>{fn:data($succesIndicator)}</ns2:successIndicator>
            <ns2:messages></ns2:messages>
            <ns2:ASSOCIATION_NAME></ns2:ASSOCIATION_NAME>
            {
                if ($ConsultaListaContratistaDelEstadoResponse/FICOSTATECONTRACTLISTWSType/gFICOSTATECONTRACTLISTWSDetailType/mFICOSTATECONTRACTLISTWSDetailType/CustomerID)
                then <ns2:CUSTOMER_ID>{fn:data($ConsultaListaContratistaDelEstadoResponse/FICOSTATECONTRACTLISTWSType/gFICOSTATECONTRACTLISTWSDetailType/mFICOSTATECONTRACTLISTWSDetailType/CustomerID)}</ns2:CUSTOMER_ID>
                else ()
            }
            {
                if ($ConsultaListaContratistaDelEstadoResponse/FICOSTATECONTRACTLISTWSType/gFICOSTATECONTRACTLISTWSDetailType/mFICOSTATECONTRACTLISTWSDetailType/NombreCompleto)
                then <ns2:CUSTOMER_NAME>{fn:data($ConsultaListaContratistaDelEstadoResponse/FICOSTATECONTRACTLISTWSType/gFICOSTATECONTRACTLISTWSDetailType/mFICOSTATECONTRACTLISTWSDetailType/NombreCompleto)}</ns2:CUSTOMER_NAME>
                else ()
            }
        </ns2:consultaListaClienteResponse>
    </ns2:sjConsultaListasClienteResponse>
};

local:func($succesIndicator, $ConsultaListaContratistaDelEstadoResponse)