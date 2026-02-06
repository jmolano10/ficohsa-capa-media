xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaMultipleImagenesChequesRequest" element="ns1:consultaMultipleImagenesChequesRequest" location="../xsd/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$convertirImagenResponseA" element="ns0:convertirImagenResponse" location="../../../BusinessServices/ABKGT/consultaImagenCheque/xsd/XMLSchema_-131460889.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$convertirImagenResponseR" element="ns0:convertirImagenResponse" location="../../../BusinessServices/ABKGT/consultaImagenCheque/xsd/XMLSchema_-131460889.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaMultipleImagenesChequeArmarNodoImagen/";
declare namespace ns0 = "http://ConsultaImagen.ficohsa.com/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";

declare function xf:consultaMultipleImagenesChequeArmarNodoImagen($consultaMultipleImagenesChequesRequest as element(ns1:consultaMultipleImagenesChequesRequest),
    $Año as xs:string,
    $Mes as xs:string,
    $Dia as xs:string,
    $Cheque as xs:string,
    $convertirImagenResponseA as element(ns0:convertirImagenResponse),
    $convertirImagenResponseR as element(ns0:convertirImagenResponse))
    as element(*) {
    <Imagen>
			<CHEQUE_NUMBER>{$Cheque}</CHEQUE_NUMBER>
			<TRANSACTION_DATE>{fn:concat($Año,$Mes,$Dia)}</TRANSACTION_DATE>
			<CHEQUE_IMAGE_FRONT>{
			if(fn:substring(fn:string($convertirImagenResponseA/ImagenBase64/text()),1,5)!='ERROR')then(
				fn:string($convertirImagenResponseA/ImagenBase64/text())
			)
			else('')
			}
			</CHEQUE_IMAGE_FRONT>
			<CHEQUE_IMAGE_BACK>{
			if(fn:substring(fn:string($convertirImagenResponseR/ImagenBase64/text()),1,5)!='ERROR')then
			(
				fn:string($convertirImagenResponseR/ImagenBase64/text())
			)else('')	
			}</CHEQUE_IMAGE_BACK>
			<FILE_EXTENSION>tif</FILE_EXTENSION>
			<QUERY_STATUS>{
			if(fn:substring(fn:string($convertirImagenResponseA/ImagenBase64/text()),1,5)='ERROR' or fn:substring(fn:string($convertirImagenResponseR/ImagenBase64/text()),1,5)='ERROR') then
			(
				'ERROR'
			)
			else('SUCCESS')
			}</QUERY_STATUS>
			<QUERY_DESCRIPTION>{
			if( (fn:substring(fn:string($convertirImagenResponseA/ImagenBase64/text()),1,5)='ERROR') and (fn:substring(fn:string($convertirImagenResponseR/ImagenBase64/text()),1,5)='ERROR'))then
			(
				fn:concat(fn:substring(fn:string($convertirImagenResponseA/ImagenBase64/text()),7,1000),'. ',fn:substring(fn:string($convertirImagenResponseR/ImagenBase64/text()),7,1000))
			)else if(fn:substring(fn:string($convertirImagenResponseA/ImagenBase64/text()),1,5)='ERROR') then
			(
				fn:substring(fn:string($convertirImagenResponseA/ImagenBase64/text()),7,1000)
			)else if(fn:substring(fn:string($convertirImagenResponseR/ImagenBase64/text()),1,5)='ERROR') then
			(
				fn:substring(fn:string($convertirImagenResponseR/ImagenBase64/text()),7,1000)
			)else('')
			}</QUERY_DESCRIPTION>
</Imagen>
};

declare variable $consultaMultipleImagenesChequesRequest as element(ns1:consultaMultipleImagenesChequesRequest) external;
declare variable $Año as xs:string external;
declare variable $Mes as xs:string external;
declare variable $Dia as xs:string external;
declare variable $Cheque as xs:string external;
declare variable $convertirImagenResponseA as element(ns0:convertirImagenResponse) external;
declare variable $convertirImagenResponseR as element(ns0:convertirImagenResponse) external;

xf:consultaMultipleImagenesChequeArmarNodoImagen($consultaMultipleImagenesChequesRequest,
    $Año,
    $Mes,
    $Dia,
    $Cheque,
    $convertirImagenResponseA,
    $convertirImagenResponseR)