xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLists/V1.0/GetCustomerLists_BS.xsd" ::)
declare namespace ns5="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaOFAC";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultaListaOFAC/consultaListaOFAC_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarListaFatca";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultarListaFatca/consultarListaFatca_sp.xsd" ::)
declare namespace ns6="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultaListaNoFATCA/ConsultaClienteNoFatca_PS.xsd" ::)
declare namespace ns7="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasContratistaDelEstado";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultaListaContratistaDelEstado/ConsultaListaContratistaDelEstado_PS.xsd" ::)
declare namespace ns8="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerRelatedList";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerRelatedList/GetCustomerRelatedList_sp.xsd" ::)


declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";

declare variable $consultadelistanegraResponse as element() (:: schema-element(ns2:ConsultadelistanegraResponse) ::) external;
declare variable $consultadelistaPEPResponse as element() (:: schema-element(ns2:ConsultadelistaPEPResponse) ::) external;
declare variable $consultadelistagrisResponse as element() (:: schema-element(ns2:ConsultaListaGrisResponse) ::) external;
declare variable $consultaListaFatcaResponse as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $consultaListaOFACResponse as element() (:: schema-element(ns4:OutputParameters) ::) external;
declare variable $consultaListaNoFatcaResponse as element() (:: schema-element(ns6:sjConsultaListasClienteResponse) ::) external;
declare variable $consultaListaContratistaDelEstado as element() (:: schema-element(ns7:sjConsultaListasContratistaDelEstadoResponse) ::) external;
declare variable $consultaListaRelacionadas as element() (:: schema-element(ns8:OutputParameters) ::) external;

declare function ns1:sjConsultaListasClienteOut($consultadelistanegraResponse as element() (:: schema-element(ns2:ConsultadelistanegraResponse) ::), 
                                                $consultadelistaPEPResponse as element() (:: schema-element(ns2:ConsultadelistaPEPResponse) ::), 
                                                $consultadelistagrisResponse as element() (:: schema-element(ns2:ConsultaListaGrisResponse) ::), 
                                                $consultaListaFatcaResponse as element() (:: schema-element(ns3:OutputParameters) ::), 
                                                $consultaListaOFACResponse as element() (:: schema-element(ns4:OutputParameters) ::),
                                                $consultaListaNoFatcaResponse as element() (:: schema-element(ns6:sjConsultaListasClienteResponse) ::),
                                                $consultaListaContratistaDelEstado as element() (:: schema-element(ns7:sjConsultaListasContratistaDelEstadoResponse) ::),
                                                $consultaListaRelacionadas as element() (:: schema-element(ns8:OutputParameters) ::)) 
                                                as element() (:: schema-element(ns5:getCustomerListsHN_SJResponse) ::) {
    <ns5:getCustomerListsHN_SJResponse>
        <ns5:consultaListaClienteResponse>
            {
                if ($consultadelistanegraResponse/Status/successIndicator)
                then <ns5:successIndicator>{fn:data($consultadelistanegraResponse/Status/successIndicator)}</ns5:successIndicator>
                else ()
            }
            {
                for $messages in $consultadelistanegraResponse/Status/messages
                return 
                <ns5:messages>{fn:data($consultadelistanegraResponse/Status/messages)}</ns5:messages>
            }
            <ns5:ASSOCIATION_NAME>BLACKLIST</ns5:ASSOCIATION_NAME>
            {
                for $DOCNUMBER in $consultadelistanegraResponse/WSFICOBLACKLISTDETType[1]/gWSFICOBLACKLISTDETDetailType/mWSFICOBLACKLISTDETDetailType[1]/DOCNUMBER
                    return
                        <ns5:CUSTOMER_ID>{ data($DOCNUMBER) }</ns5:CUSTOMER_ID>
            }
            {
                    let $CUSTNAME := fn:string($consultadelistanegraResponse/WSFICOBLACKLISTDETType[1]/gWSFICOBLACKLISTDETDetailType/mWSFICOBLACKLISTDETDetailType[1]/CUSTNAME/text())
                    let $CUSTSURNAME := fn:string($consultadelistanegraResponse/WSFICOBLACKLISTDETType[1]/gWSFICOBLACKLISTDETDetailType/mWSFICOBLACKLISTDETDetailType[1]/CUSTSURNAME/text())
                    return
                        <ns5:CUSTOMER_NAME>{ fn:normalize-space(fn:concat($CUSTNAME," ",$CUSTSURNAME)) }</ns5:CUSTOMER_NAME>
                }
        </ns5:consultaListaClienteResponse>
        <ns5:consultaListaClienteResponse>
            {
                for $successIndicator in $consultadelistaPEPResponse/Status/successIndicator
                return
                    <ns5:successIndicator>{ data($successIndicator) }</ns5:successIndicator>
            }
            {
                for $messages in $consultadelistaPEPResponse/Status/messages
                return
                    <ns5:messages>{ data($messages) }</ns5:messages>
            }
            <ns5:ASSOCIATION_NAME>PEP</ns5:ASSOCIATION_NAME>
            {
                for $DOCUMENTNUMBER in $consultadelistaPEPResponse/WSFICOPEPDETType[1]/gWSFICOPEPDETDetailType/mWSFICOPEPDETDetailType[1]/DOCUMENTNUMBER
                return
                    <ns5:CUSTOMER_ID>{ data($DOCUMENTNUMBER) }</ns5:CUSTOMER_ID>
            }
            {
                let $GIVENNAMES := fn:string($consultadelistaPEPResponse/WSFICOPEPDETType[1]/gWSFICOPEPDETDetailType/mWSFICOPEPDETDetailType[1]/GIVENNAMES/text())
                let $FAMILYNAME := fn:string($consultadelistaPEPResponse/WSFICOPEPDETType[1]/gWSFICOPEPDETDetailType/mWSFICOPEPDETDetailType[1]/FAMILYNAME/text())
                return
                    <ns5:CUSTOMER_NAME>{ fn:normalize-space(fn:concat($GIVENNAMES," ",$FAMILYNAME)) }</ns5:CUSTOMER_NAME>
            }
        </ns5:consultaListaClienteResponse>
        <ns5:consultaListaClienteResponse>
            {
                <ns5:successIndicator>{ fn:string($consultaListaFatcaResponse/ns3:PV_CODIGO_ERROR/text()) }</ns5:successIndicator>,
                <ns5:messages>{ fn:string($consultaListaFatcaResponse/ns3:PV_MENSAJE_ERROR/text()) }</ns5:messages>,
                <ns5:ASSOCIATION_NAME>FATCA</ns5:ASSOCIATION_NAME>,
                <ns5:CUSTOMER_ID></ns5:CUSTOMER_ID>,
                <ns5:CUSTOMER_NAME>{ fn:string($consultaListaFatcaResponse/ns3:PV_NOMBRE_COMPLETO/text()) }</ns5:CUSTOMER_NAME>
            }
        </ns5:consultaListaClienteResponse>
        <ns5:consultaListaClienteResponse>
            {
                for $successIndicator in $consultadelistagrisResponse/Status/successIndicator
                return
                    <ns5:successIndicator>{ data($successIndicator) }</ns5:successIndicator>
            }
            {
                for $messages in $consultadelistagrisResponse/Status/messages
                return
                    <ns5:messages>{ data($messages) }</ns5:messages>
            }
            <ns5:ASSOCIATION_NAME>GRAYLIST</ns5:ASSOCIATION_NAME>
            {
                for $IDENTNUMBER in $consultadelistagrisResponse/WSFICOBUSCARGRAYLISTType[1]/gWSFICOBUSCARGRAYLISTDetailType/mWSFICOBUSCARGRAYLISTDetailType[1]/IDENTNUMBER
                return
                    <ns5:CUSTOMER_ID>{ data($IDENTNUMBER) }</ns5:CUSTOMER_ID>
            }
            {
                let $NAME := fn:string($consultadelistagrisResponse/WSFICOBUSCARGRAYLISTType[1]/gWSFICOBUSCARGRAYLISTDetailType/mWSFICOBUSCARGRAYLISTDetailType[1]/NAME/text())
                return
                    <ns5:CUSTOMER_NAME>{ fn:normalize-space($NAME) }</ns5:CUSTOMER_NAME>
            }
        </ns5:consultaListaClienteResponse>
        <ns5:consultaListaClienteResponse>
                {
                    <ns5:successIndicator>{ fn:string($consultaListaOFACResponse/ns4:RESPONSE_CODE/text()) }</ns5:successIndicator>,
                    <ns5:messages>{ fn:string($consultaListaOFACResponse/ns4:RESPONSE_MESSAGE/text()) }</ns5:messages>,
                    <ns5:ASSOCIATION_NAME>OFAC</ns5:ASSOCIATION_NAME>,
                    <ns5:CUSTOMER_ID></ns5:CUSTOMER_ID>,
                    <ns5:CUSTOMER_NAME>{ fn:string($consultaListaOFACResponse/ns4:ENTITY_NAME/text()) }</ns5:CUSTOMER_NAME>
                }
        </ns5:consultaListaClienteResponse>
        <ns5:consultaListaClienteResponse>
            {
                <ns5:successIndicator>{fn:data($consultaListaNoFatcaResponse/ns1:consultaListaClienteResponse/ns1:successIndicator)}</ns5:successIndicator>,
                <ns5:messages></ns5:messages>,
                <ns5:ASSOCIATION_NAME>NOFATCA</ns5:ASSOCIATION_NAME>,
                <ns5:CUSTOMER_ID>{fn:data($consultaListaNoFatcaResponse/ns1:consultaListaClienteResponse/ns1:CUSTOMER_ID)}</ns5:CUSTOMER_ID>,
                <ns5:CUSTOMER_NAME>{fn:data($consultaListaNoFatcaResponse/ns1:consultaListaClienteResponse/ns1:CUSTOMER_NAME)}</ns5:CUSTOMER_NAME>
            }
        </ns5:consultaListaClienteResponse>
        <ns5:consultaListaClienteResponse>
            <ns5:successIndicator>{fn:data($consultaListaContratistaDelEstado/ns7:consultaListaClienteResponse/ns7:successIndicator)}</ns5:successIndicator>
            <ns5:messages></ns5:messages>
            <ns5:ASSOCIATION_NAME>STATECONTRACTOR</ns5:ASSOCIATION_NAME>
            <ns5:CUSTOMER_ID>{fn:data($consultaListaContratistaDelEstado/ns7:consultaListaClienteResponse/ns7:CUSTOMER_ID)}</ns5:CUSTOMER_ID>
            <ns5:CUSTOMER_NAME>{fn:data($consultaListaContratistaDelEstado/ns7:consultaListaClienteResponse/ns7:CUSTOMER_NAME)}</ns5:CUSTOMER_NAME>
        </ns5:consultaListaClienteResponse>
        <ns5:consultaListaClienteResponse>
            <ns5:successIndicator>SUCCESS</ns5:successIndicator>
            <ns5:messages></ns5:messages>
            <ns5:ASSOCIATION_NAME>RELATEDLIST</ns5:ASSOCIATION_NAME>
            <ns5:CUSTOMER_ID></ns5:CUSTOMER_ID>
            <ns5:CUSTOMER_NAME>
            {
                if (fn:string($consultaListaRelacionadas/ns8:PV_RESPUESTA/text()) = "NO")
                then ('')
                else (fn:data($consultaListaRelacionadas/ns8:PV_RESPUESTA))
            }
            </ns5:CUSTOMER_NAME>
        </ns5:consultaListaClienteResponse>
    </ns5:getCustomerListsHN_SJResponse>
};

ns1:sjConsultaListasClienteOut($consultadelistanegraResponse, $consultadelistaPEPResponse, $consultadelistagrisResponse, $consultaListaFatcaResponse, $consultaListaOFACResponse, $consultaListaNoFatcaResponse, $consultaListaContratistaDelEstado, $consultaListaRelacionadas)