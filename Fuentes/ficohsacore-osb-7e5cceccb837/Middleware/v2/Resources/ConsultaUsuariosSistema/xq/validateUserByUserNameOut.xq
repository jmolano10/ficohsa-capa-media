(:: pragma bea:global-element-parameter parameter="$consultaUsuariosSistema" element="ns0:consultaUsuariosSistema" location="../xsd/consultaUsuariosSistemaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validateUserByUserNameMessageOut" element="ns1:ValidateUserByUserNameMessageOut" location="../../../BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.svc.singleWsdl.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaUsuariosSistemaResponse" location="../xsd/consultaUsuariosSistemaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosSistemaTypes";
declare namespace ns1 = "urn:tailored.icbanking.services.administration.users";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosSistema/xq/validateUserByUserNameOut/";

declare function xf:validateUserByUserNameOut($consultaUsuariosSistema as element(ns0:consultaUsuariosSistema),
    $validateUserByUserNameMessageOut as element(ns1:ValidateUserByUserNameMessageOut))
    as element(ns0:consultaUsuariosSistemaResponse) {
        <ns0:consultaUsuariosSistemaResponse>
            <ns0:consultaUsuariosSistemaResponseType>
                <ns0:consultaUsuariosSistemaResponseRecordType>
                    {
                        for $APPLICATION in $consultaUsuariosSistema/APPLICATION
                        return
                            <APPLICATION>{ data($APPLICATION) }</APPLICATION>
                    }
                    {
                        for $SIGN_ON_NAME in $consultaUsuariosSistema/SIGN_ON_NAME
                        return
                            <SIGN_ON_NAME>{ data($SIGN_ON_NAME) }</SIGN_ON_NAME>
                    }
                    <ADDITIONAL_ITEMS>
                        <ITEM>
                            <NAME>SECOND_AUTH</NAME>
                            <VALUE>{ data($validateUserByUserNameMessageOut/ns1:SecurityDeviceId) }</VALUE>
                        </ITEM>
                        <ITEM>
                            <NAME>USER_PERSONAL_ID</NAME>
                            <VALUE>{ data($validateUserByUserNameMessageOut/ns1:DocumentNumber) }</VALUE>
                        </ITEM>
                    </ADDITIONAL_ITEMS>
                </ns0:consultaUsuariosSistemaResponseRecordType>
            </ns0:consultaUsuariosSistemaResponseType>
        </ns0:consultaUsuariosSistemaResponse>
};

declare variable $consultaUsuariosSistema as element(ns0:consultaUsuariosSistema) external;
declare variable $validateUserByUserNameMessageOut as element(ns1:ValidateUserByUserNameMessageOut) external;

xf:validateUserByUserNameOut($consultaUsuariosSistema,
    $validateUserByUserNameMessageOut)