xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDAOResponse" element="ns1:ConsultaDAOResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaOficialesNegocioResponse" location="consultaOficialesNegocioTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioOut/";

declare function xf:consultaOficialesNegocioOut($consultaDAOResponse as element(ns1:ConsultaDAOResponse))
    as element(ns0:consultaOficialesNegocioResponse) {
        <ns0:consultaOficialesNegocioResponse>
            {
                for $gWSADMINDEPTACCTOFFICERDetailType in $consultaDAOResponse/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType
                return
                    <ns0:consultaOficialesNegocioResponseType>
                        {
                            for $mWSADMINDEPTACCTOFFICERDetailType in $gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType
                            return
                                <ns0:consultaOficialesNegocioResponseRecordType>
                                    {
                                        for $ID in $mWSADMINDEPTACCTOFFICERDetailType/ID
                                        return
                                            <OFFICER_CODE>{ data($ID) }</OFFICER_CODE>
                                    }
                                    {
                                        for $NAME in $mWSADMINDEPTACCTOFFICERDetailType/NAME
                                        return
                                            <OFFICER_NAME>{ data($NAME) }</OFFICER_NAME>
                                    }
                                    {
                                        for $DEPTPARENT in $mWSADMINDEPTACCTOFFICERDetailType/DEPTPARENT
                                        return
                                            <BRANCH_CODE>{ data($DEPTPARENT) }</BRANCH_CODE>
                                    }
                                    {
                                        for $DEPTPARENTNAME in $mWSADMINDEPTACCTOFFICERDetailType/DEPTPARENTNAME
                                        return
                                            <BRANCH_NAME>{ data($DEPTPARENTNAME) }</BRANCH_NAME>
                                    }
                                    {
                                        for $ID in $mWSADMINDEPTACCTOFFICERDetailType/ID
                                        return
                                            <DEPARTMENT_ID>{ substring($ID,1,6) }</DEPARTMENT_ID>
                                    }
                                    {
                                        for $AREA in $mWSADMINDEPTACCTOFFICERDetailType/AREA
                                        return
                                            <DEPARTMENT_NAME>{ data($AREA) }</DEPARTMENT_NAME>
                                    }
                                </ns0:consultaOficialesNegocioResponseRecordType>
                        }
                    </ns0:consultaOficialesNegocioResponseType>
            }
        </ns0:consultaOficialesNegocioResponse>
};

declare variable $consultaDAOResponse as element(ns1:ConsultaDAOResponse) external;

xf:consultaOficialesNegocioOut($consultaDAOResponse)