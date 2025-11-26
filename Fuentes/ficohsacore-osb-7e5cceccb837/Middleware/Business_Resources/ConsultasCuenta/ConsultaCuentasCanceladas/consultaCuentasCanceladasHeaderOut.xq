(:: pragma bea:global-element-parameter parameter="$consultadecuentascanceladasResponse1" element="ns0:ConsultadecuentascanceladasResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaCuentasCanceladas/consultaCuentasCanceladasHeaderOut/";

declare function xf:consultaCuentasCanceladasHeaderOut($consultadecuentascanceladasResponse1 as element(ns0:ConsultadecuentascanceladasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>    
        {
        	if (empty($consultadecuentascanceladasResponse1/WSACCOUNTCLOSEDType[1]/ZERORECORDS/text())) then (
        		<successIndicator>{ data($consultadecuentascanceladasResponse1/Status/successIndicator) }</successIndicator>,
        		<messages>{ data($consultadecuentascanceladasResponse1/Status/messages) }</messages>
        	) else (
        		<successIndicator>NO RECORDS</successIndicator>,
        		<messages>{ data($consultadecuentascanceladasResponse1/WSACCOUNTCLOSEDType[1]/ZERORECORDS) }</messages>
        	)
        }
        </ns1:ResponseHeader>
};

declare variable $consultadecuentascanceladasResponse1 as element(ns0:ConsultadecuentascanceladasResponse) external;

xf:consultaCuentasCanceladasHeaderOut($consultadecuentascanceladasResponse1)