xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeusuariosdelsistemaResponse" element="ns0:ConsultadeusuariosdelsistemaResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaUsuariosSistemaResponse" location="consultaUsuariosSistemaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosSistemaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/ConsultaUsuariosSistema/consultaUsuariosSistemaOut/";

declare function xf:consultaUsuariosSistemaOut($consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse))
    as element(ns1:consultaUsuariosSistemaResponse) {
        <ns1:consultaUsuariosSistemaResponse>
            {
                for $gWSUSERDetailType in $consultadeusuariosdelsistemaResponse/WSUSERType[1]/gWSUSERDetailType
                return
                    <ns1:consultaUsuariosSistemaResponseType>
                        {
                            for $mWSUSERDetailType in $gWSUSERDetailType/mWSUSERDetailType
                            return
                                <ns1:consultaUsuariosSistemaResponseRecordType>
                                    {
                                        for $ID in $mWSUSERDetailType/ID
                                        return
                                            <USER_ID>{ data($ID) }</USER_ID>
                                    }
                                    {
                                        for $USERNAME in $mWSUSERDetailType/USERNAME
                                        return
                                            <USER_NAME>{ data($USERNAME) }</USER_NAME>
                                    }
                                    {
                                        for $DEPTCODE in $mWSUSERDetailType/DEPTCODE
                                        return
                                            <DEPT_CODE>{ data($DEPTCODE) }</DEPT_CODE>
                                    }
                                    {
                                        for $APPLICATION in $mWSUSERDetailType/APPLICATION
                                        return
                                            <APPLICATION>{ data($APPLICATION) }</APPLICATION>
                                    }
                                    {
                                        for $OFFICERDAO in $mWSUSERDetailType/OFFICERDAO
                                        return
                                            <OFFICER_DAO>{ data($OFFICERDAO) }</OFFICER_DAO>
                                    }
                                    {
                                        for $BRANCHCODE in $mWSUSERDetailType/BRANCHCODE
                                        return
                                            <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
                                    }
                                    {
                                        for $BRANCHNAME in $mWSUSERDetailType/BRANCHNAME
                                        return
                                            <BRANCH_NAME>{ data($BRANCHNAME) }</BRANCH_NAME>
                                    }
                                    {
                                        for $SIGNONNAME in $mWSUSERDetailType/SIGNONNAME
                                        return
                                            <SIGN_ON_NAME>{ data($SIGNONNAME) }</SIGN_ON_NAME>
                                    }
                                </ns1:consultaUsuariosSistemaResponseRecordType>
                        }
                    </ns1:consultaUsuariosSistemaResponseType>
            }
        </ns1:consultaUsuariosSistemaResponse>
};

declare variable $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse) external;

xf:consultaUsuariosSistemaOut($consultadeusuariosdelsistemaResponse)