xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registroContratoACH" element="ns2:registroContratoACH" location="../xsd/registroContratoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RegistrodeContratoACHDebito" location="../../../BusinessServices/T24/ACHContratos/xsd/XMLSchema_-1123798799.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/registroContratoACHTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistroContratoACH/xq/registrarContratoACHDebitoEntranteIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:registrarContratoACHDebitoEntranteIn($requestHeader as element(ns0:RequestHeader),
    $registroContratoACH as element(ns2:registroContratoACH))
    as element(ns1:RegistrodeContratoACHDebito) {
        <ns1:RegistrodeContratoACHDebito>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOACHDEBITOSINPUTWSType id = "{ data($registroContratoACH/ID_CONTRATO_ACH) }">
                <LUGAR>{ data($registroContratoACH/datosBancoExternoType/DBE_CUENTA) }</LUGAR>
                {
                    for $FECHA_CREACION in $registroContratoACH/FECHA_CREACION
                    return
                        <DATE>{ data($FECHA_CREACION) }</DATE>
                }
                <IDCOMPANIA>{ data($registroContratoACH/datosBancoExternoType/DBE_CODIGO_BANCO) }</IDCOMPANIA>
                <AUTHFIRM>{ data($registroContratoACH/datosBancoExternoType/DBE_IDENTIDAD) }</AUTHFIRM>
                <CONCEPTO>{ data($registroContratoACH/datosBancoExternoType/DBE_NOMBRE_CLIENTE) }</CONCEPTO>
                {
                    for $NO_CONTRATO in $registroContratoACH/NO_CONTRATO
                    return
                        <NOCONTRATO>{ data($NO_CONTRATO) }</NOCONTRATO>
                }
                <NOMBRECUENTA>{ data($registroContratoACH/datosBancoFicohsaType/DBF_NOMBRE_CLIENTE) }</NOMBRECUENTA>
                <IDENTIFICACION>{ data($registroContratoACH/datosBancoFicohsaType/DBF_IDENTIDAD) }</IDENTIFICACION>
                {
                    for $DBF_TELEFONO in $registroContratoACH/datosBancoFicohsaType/DBF_TELEFONO
                    return
                        <TELEFONO>{ data($DBF_TELEFONO) }</TELEFONO>
                }
                {
                    for $DBF_EMAIL in $registroContratoACH/datosBancoFicohsaType/DBF_EMAIL
                    return
                        <CORREO>{ data($DBF_EMAIL) }</CORREO>
                }
                {
                    for $DBF_CODIGO_BANCO in $registroContratoACH/datosBancoFicohsaType/DBF_CODIGO_BANCO
                    return
                        <BANCO>{ data($DBF_CODIGO_BANCO) }</BANCO>
                }
                <NOCUENTA>{ data($registroContratoACH/datosBancoFicohsaType/DBF_CUENTA) }</NOCUENTA>
                <TIPOCUENTA>{ data($registroContratoACH/datosBancoFicohsaType/DBF_TIPO_CUENTA) }</TIPOCUENTA>
                <TIPOMONEDA>{ data($registroContratoACH/datosBancoFicohsaType/DBF_MONEDA) }</TIPOMONEDA>
                <TIPOVIGENCIA>{ data($registroContratoACH/TIPO_VIGENCIA) }</TIPOVIGENCIA>
                <TIPOMONTO>{ data($registroContratoACH/TIPO_MONTO) }</TIPOMONTO>
                <TIPOPERIODICIDAD>{ data($registroContratoACH/PERIOCIDAD) }</TIPOPERIODICIDAD>
                {
                    for $ESTADO_CONTRATO in $registroContratoACH/ESTADO_CONTRATO
                    return
                        <ESTADOCONTRATO>{ data($ESTADO_CONTRATO) }</ESTADOCONTRATO>
                }
                {
                    for $FECHA_INICIO in $registroContratoACH/FECHA_INICIO
                    return
                        <FECHAINICIO>{ data($FECHA_INICIO) }</FECHAINICIO>
                }
                {
                    for $FECHA_FINAL in $registroContratoACH/FECHA_FINAL
                    return
                        <FECHAFINALIZACION>{ data($FECHA_FINAL) }</FECHAFINALIZACION>
                }
                {
                    for $NO_MAX_TRANSACCIONES in $registroContratoACH/NO_MAX_TRANSACCIONES
                    return
                        <MAXIMOTRANSACCION>{ data($NO_MAX_TRANSACCIONES) }</MAXIMOTRANSACCION>
                }
                {
                    for $NO_MAX_DEBITOS in $registroContratoACH/NO_MAX_DEBITOS
                    return
                        <MAXIMODEBITOS>{ data($NO_MAX_DEBITOS) }</MAXIMODEBITOS>
                }
                {
                    for $FRECUENCIA in $registroContratoACH/FRECUENCIA
                    return
                        <CADA>{ data($FRECUENCIA) }</CADA>
                }
                <gDELACH>
                    {
                        for $detalleFrecuencias in $registroContratoACH/detalleFrecuencias
                        return
                            <mDELACH>
                                {
                                    for $RANGO_INI in $detalleFrecuencias/RANGO_INI
                                    return
                                        <DELACH>{ data($RANGO_INI) }</DELACH>
                                }
                                {
                                    for $RANGO_FIN in $detalleFrecuencias/RANGO_FIN
                                    return
                                        <ALACH>{ data($RANGO_FIN) }</ALACH>
                                }
                            </mDELACH>
                    }
                </gDELACH>
                <TIPOCONTRATO>{ data($registroContratoACH/TIPO_CONTRATO) }</TIPOCONTRATO>
                {
                    for $TIPO_PRODUCTO in $registroContratoACH/TIPO_PRODUCTO
                    return
                        <TIPOPRODUCTO>{ data($TIPO_PRODUCTO) }</TIPOPRODUCTO>
                }
                {
                    for $ID_CONVENIO_T24 in $registroContratoACH/ID_CONVENIO_T24
                    return
                        <IDCONVENIOT24>{ data($ID_CONVENIO_T24) }</IDCONVENIOT24>
                }
                {
                    for $DIA_EJECUCION in $registroContratoACH/DIA_EJECUCION
                    return
                        <DIAEJECUCION>{ data($DIA_EJECUCION) }</DIAEJECUCION>
                }
            </FICOACHDEBITOSINPUTWSType>
        </ns1:RegistrodeContratoACHDebito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $registroContratoACH as element(ns2:registroContratoACH) external;

xf:registrarContratoACHDebitoEntranteIn($requestHeader,
    $registroContratoACH)