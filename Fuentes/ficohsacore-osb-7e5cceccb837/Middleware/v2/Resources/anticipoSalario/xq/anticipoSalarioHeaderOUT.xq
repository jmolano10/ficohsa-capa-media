(:: pragma bea:global-element-parameter parameter="$anticipoSalarioResponse1" element="ns0:AnticipoSalarioResponse" location="../../../BusinessServices/T24/AnticipoSalario/xsd/AnticipoSalarioTypes02.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaAnticipoSalarioResponse1" element="ns0:ConsultaAnticipoSalarioResponse" location="../../../BusinessServices/T24/AnticipoSalario/xsd/AnticipoSalarioTypes02.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/anticipoSalario/xq/anticipoSalarioHeaderOUT/";
declare variable $multiMessages as xs:string external;

declare function xf:anticipoSalarioHeaderOUT($anticipoSalarioResponse1 as element(ns0:AnticipoSalarioResponse),
    $consultaAnticipoSalarioResponse1 as element(ns0:ConsultaAnticipoSalarioResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $anticipoSalarioResponse1/Status/transactionId
                return
                        <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $anticipoSalarioResponse1/Status/successIndicator
                return
                	if(fn:contains(data($multiMessages),"MISSING ACCOUNT")) then
                        <successIndicator> NO RECORDS </successIndicator>
                    else
                        <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $anticipoSalarioResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};


declare variable $anticipoSalarioResponse1 as element(ns0:AnticipoSalarioResponse) external;
declare variable $consultaAnticipoSalarioResponse1 as element(ns0:ConsultaAnticipoSalarioResponse) external;

xf:anticipoSalarioHeaderOUT($anticipoSalarioResponse1,
    $consultaAnticipoSalarioResponse1)