xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadatosFATCAResponse" element="ns0:ConsultadatosFATCAResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFATCAResponse" location="../../ConsultaListasRegulatorias/xsd/consultaListasRegulatoriasTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaListasRegulatoriasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFATCA/xq/consultadatosFATCAOut/";

declare function xf:consultadatosFATCAOut($consultadatosFATCAResponse as element(ns0:ConsultadatosFATCAResponse))
    as element(ns1:consultaFATCAResponse) {
        <ns1:consultaFATCAResponse>
            <IS_MULTI_NATIONALITY>{ data($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/POSMONAC) }</IS_MULTI_NATIONALITY>
            <NATIONALITIES>
        	{	
        		let $NACIONALITY1 := fn:string($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/NACIONALITY1/text())
        		return
        		(
            		if($NACIONALITY1 != "")then(
            			<NATIONALITY_TYPE>
                    		<NATIONALITY>{ data($NACIONALITY1) }</NATIONALITY>
                		</NATIONALITY_TYPE>
            		)else()
            		
            	)
			}
			{	
        		let $NACIONALITY2 := fn:string($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/NACIONALITY2/text())
        		return
        		(
            		if($NACIONALITY2 != "")then(
            			<NATIONALITY_TYPE>
                    		<NATIONALITY>{ data($NACIONALITY2) }</NATIONALITY>
                		</NATIONALITY_TYPE>
            		)else()
            		
            	)
			}
			{	
        		let $NACIONALITY3 := fn:string($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/NACIONALITY3/text())
        		return
        		(
            		if($NACIONALITY3 != "")then(
            			<NATIONALITY_TYPE>
                    		<NATIONALITY>{ data($NACIONALITY3) }</NATIONALITY>
                		</NATIONALITY_TYPE>
            		)else()
            		
            	)
			}             
            </NATIONALITIES>
            <IS_RESIDENT_USA>{ data($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/ISUSRESIDENT) }</IS_RESIDENT_USA>
            <RES_MIGRATORY_EFFECTS>{ data($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/ISMIGRRESIDENT) }</RES_MIGRATORY_EFFECTS>
            <COUNTRY_RES_TAX_EFFECTS>{ data($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/TAXCOUNTRY) }</COUNTRY_RES_TAX_EFFECTS>
            <FISCALID_IN_USA>{ data($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/USTAXID) }</FISCALID_IN_USA>
            <FISCALID_ANOTHER_COUNTRY>{ data($consultadatosFATCAResponse/WSCUSTFATCAAPType[1]/gWSCUSTFATCAAPDetailType/mWSCUSTFATCAAPDetailType[1]/OTHERCOUNTRYTAXNUMBER) }</FISCALID_ANOTHER_COUNTRY>
        </ns1:consultaFATCAResponse>
};

declare variable $consultadatosFATCAResponse as element(ns0:ConsultadatosFATCAResponse) external;

xf:consultadatosFATCAOut($consultadatosFATCAResponse)