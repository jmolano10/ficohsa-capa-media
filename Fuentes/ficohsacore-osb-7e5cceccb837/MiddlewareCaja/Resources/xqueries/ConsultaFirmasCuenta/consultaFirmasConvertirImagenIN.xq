(:: pragma bea:global-element-parameter parameter="$consultaImagenFirmasResponse1" element="ns0:consultaImagenFirmasResponse" location="../../../../Middleware/Business_Resources/consultasImagen/ConsultaImagenFirmas/consultaImagenFirmasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:convertirImagen" location="../../xsds/ConsultarImagen/ConsultarImagen_schema1.xsd" ::)

declare namespace ns1 = "http://ConsultaImagen.ficohsa.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaImagenFirmasTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaFirmasCuenta/consultaFirmasConvertirImagenIN2/";

declare function xf:consultaFirmasConvertirImagenIN2($consultaImagenFirmasResponse1 as element(ns0:consultaImagenFirmasResponse),
    $path as xs:string,
    $index as xs:string)
    as element(ns1:convertirImagen) {
        <ns1:convertirImagen>
            {
                let $IMAGELOCATION := $consultaImagenFirmasResponse1/ns0:consultaImagenFirmasResponseType/ns0:consultaImagenFirmasResponseRecordType[xs:integer($index)]/SIGNATURE_IMAGE
                let $array := tokenize(data($IMAGELOCATION),'/')
                let $filename := $array[last()]                
                return
                    <NombreImagen>{ substring-before($filename,'.') }</NombreImagen>
            }
            {
                let $IMAGELOCATION2 := $consultaImagenFirmasResponse1/ns0:consultaImagenFirmasResponseType/ns0:consultaImagenFirmasResponseRecordType[xs:integer($index)]/SIGNATURE_IMAGE
                return
                let $array2 := tokenize(data($IMAGELOCATION2),'/')
                let $filepath2 :=  substring-after(fn:concat( fn:string-join(fn:remove($array2,fn:count($array2)),"\"), "\"),"..")
                return
                
                    <Ruta>{ fn:concat($path,$filepath2) }</Ruta>
            }
            {
                let $IMAGELOCATION3 := $consultaImagenFirmasResponse1/ns0:consultaImagenFirmasResponseType/ns0:consultaImagenFirmasResponseRecordType[xs:integer($index)]/SIGNATURE_IMAGE
                return
                
                let $array3 := tokenize(data($IMAGELOCATION3),'/')
                let $filename3 := $array3[last()]
                return
                    <FormatoOrigen>{ substring-after($filename3,'.') }</FormatoOrigen>
            }
            <FormatoDestino>BASE64</FormatoDestino>
        </ns1:convertirImagen>
};

declare variable $consultaImagenFirmasResponse1 as element(ns0:consultaImagenFirmasResponse) external;
declare variable $path as xs:string external;
declare variable $index as xs:string external;

xf:consultaFirmasConvertirImagenIN2($consultaImagenFirmasResponse1,    
 $path,
 $index)