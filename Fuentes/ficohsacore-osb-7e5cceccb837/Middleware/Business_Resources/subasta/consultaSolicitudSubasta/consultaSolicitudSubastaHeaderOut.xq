(:: pragma bea:global-element-parameter parameter="$consultadesubastaporadjudicarResponse" element="ns0:ConsultadesubastaporadjudicarResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaadjudicacionsubastaResponse" element="ns0:ConsultaadjudicacionsubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultasubastaporenviaraBCHResponse" element="ns0:ConsultasubastaporenviaraBCHResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/consultaSolicitudSubasta/consultaSolicitudSubastaHeaderOut/";

declare function xf:consultaSolicitudSubastaHeaderOut($consultadesubastaporadjudicarResponse as element(ns0:ConsultadesubastaporadjudicarResponse),
    $consultaadjudicacionsubastaResponse as element(ns0:ConsultaadjudicacionsubastaResponse),
    $consultasubastaporenviaraBCHResponse as element(ns0:ConsultasubastaporenviaraBCHResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator  := (fn:string($consultadesubastaporadjudicarResponse/Status/successIndicator/text()))  
                let $successIndicator0  := (fn:string($consultaadjudicacionsubastaResponse/Status/successIndicator/text()))
                let $successIndicator1  := (fn:string($consultasubastaporenviaraBCHResponse/Status/successIndicator/text()))  
                let $zeroRecords  := (fn:string($consultadesubastaporadjudicarResponse/WSFICOAUCINPBAWDType[1]/ZERORECORDS/text()))  
                let $zeroRecords0  := (fn:string($consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/ZERORECORDS/text()))
                let $zeroRecords1  := (fn:string($consultasubastaporenviaraBCHResponse/WSFICOEAUCINPNAUType[1]/ZERORECORDS/text()))  
                return
                    if (($successIndicator != "Success" or $successIndicator0 != "Success" or $successIndicator1 != "Success")) then
                        (<successIndicator>ERROR</successIndicator>,
                        <messages>{ concat($consultadesubastaporadjudicarResponse/Status/messages,". ",
                        					$consultaadjudicacionsubastaResponse/Status/messages, ". ",
                        					$consultasubastaporenviaraBCHResponse/Status/messages) }</messages>)
                    else 
                        if (($zeroRecords != "" and $zeroRecords0 != "" and $zeroRecords1 != "")) then
                            (<successIndicator>NO RECORDS</successIndicator>,
                            <messages>{ $zeroRecords }</messages>)
                        else 
                            <successIndicator>Success</successIndicator>
            }
		</ns1:ResponseHeader>
};

declare variable $consultadesubastaporadjudicarResponse as element(ns0:ConsultadesubastaporadjudicarResponse) external;
declare variable $consultaadjudicacionsubastaResponse as element(ns0:ConsultaadjudicacionsubastaResponse) external;
declare variable $consultasubastaporenviaraBCHResponse as element(ns0:ConsultasubastaporenviaraBCHResponse) external;

xf:consultaSolicitudSubastaHeaderOut($consultadesubastaporadjudicarResponse,
    $consultaadjudicacionsubastaResponse,
    $consultasubastaporenviaraBCHResponse)