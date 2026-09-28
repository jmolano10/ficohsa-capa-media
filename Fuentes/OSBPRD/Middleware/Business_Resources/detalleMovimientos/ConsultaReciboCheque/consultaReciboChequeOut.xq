xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaImagenChequeResponse" element="ns0:consultaImagenChequeResponse" location="../../procesoImagenesCheques/Resources/procesoImagenesChequesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientos/ConsultaReciboCheque/consultaReciboChequeOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";

declare function xf:consultaReciboChequeOut($consultaImagenChequeResponse as element(ns0:consultaImagenChequeResponse))
    as xs:string {
         concat(	"<DETAILS>","<DETAIL_RECORD>",
            			"<LABEL>Imagen Adversa de Cheque</LABEL>",
            			"<VALUE>", data($consultaImagenChequeResponse/CHEQUE_IMAGE_FRONT) ,"</VALUE>",
            		"</DETAIL_RECORD>",
            		"<DETAIL_RECORD>",
            			"<LABEL>Imagen Reversa de Cheque</LABEL>",
            			"<VALUE>", data($consultaImagenChequeResponse/CHEQUE_IMAGE_BACK) ,"</VALUE>",
            		"</DETAIL_RECORD>","</DETAILS>"
				)
};

declare variable $consultaImagenChequeResponse as element(ns0:consultaImagenChequeResponse) external;

xf:consultaReciboChequeOut($consultaImagenChequeResponse)