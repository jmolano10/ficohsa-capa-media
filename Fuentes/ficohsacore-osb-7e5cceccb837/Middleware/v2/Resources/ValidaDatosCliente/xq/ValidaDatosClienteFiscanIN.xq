(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/Fiscan/xsd/ConsultaDetalleClienteFiscan_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetalleClienteFiscan";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/ValidaDatosClienteFiscanIN/";

declare function xf:ValidaDatosClienteFiscanIN($Channel as xs:string,
    $User as xs:string,
    $SecuncialFiscan as xs:string,
    $DocumentType as xs:string,
    $DocumentNumber as xs:string,
    $Country as xs:string,
    $CountryBenefiarry as xs:string,
    $BeneficiaryName as xs:string,
    $RelationCode as xs:string,
    $TrxCode as xs:string,
    $TrxType as xs:string,
    $Date as xs:string,
    $statusResponse as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_pais>{ $Country }</ns0:i_pais>
            <ns0:i_canal>{ $Channel }</ns0:i_canal>
            <ns0:i_user>{ $User }</ns0:i_user>
            <ns0:i_fecha>{data($Date) }</ns0:i_fecha>
            <ns0:i_oficina></ns0:i_oficina>
            <ns0:t_trn>{ data($TrxCode) }</ns0:t_trn>
             <ns0:i_secuencial>{ data($SecuncialFiscan) }</ns0:i_secuencial>
            <ns0:i_tipo_tran>{ $TrxType }</ns0:i_tipo_tran>
            <ns0:i_nombre_cliente>{ $BeneficiaryName }</ns0:i_nombre_cliente>
            <ns0:i_cod_nac>{ $CountryBenefiarry }</ns0:i_cod_nac>
            <ns0:i_parentesco>{ $RelationCode }</ns0:i_parentesco>
            <ns0:i_tipo_doc>{ $DocumentType }</ns0:i_tipo_doc>
            <ns0:i_documento>{ $DocumentNumber }</ns0:i_documento>
            <ns0:i_status_response>{ $statusResponse }</ns0:i_status_response>
        </ns0:InputParameters>
};

declare variable $Channel as xs:string external;
declare variable $User as xs:string external;
declare variable $SecuncialFiscan as xs:string external;
declare variable $DocumentType as xs:string external;
declare variable $DocumentNumber as xs:string external;
declare variable $Country as xs:string external;
declare variable $CountryBenefiarry as xs:string external;
declare variable $BeneficiaryName as xs:string external;
declare variable $RelationCode as xs:string external;
declare variable $TrxCode as xs:string external;
declare variable $TrxType as xs:string external;
declare variable $Date as xs:string external;
declare variable $statusResponse as xs:string external;

xf:ValidaDatosClienteFiscanIN($Channel,
    $User,
    $SecuncialFiscan,
    $DocumentType,
    $DocumentNumber,
    $Country,
    $CountryBenefiarry,
    $BeneficiaryName,
    $RelationCode,
    $TrxCode,
    $TrxType,
    $Date,
    $statusResponse)
