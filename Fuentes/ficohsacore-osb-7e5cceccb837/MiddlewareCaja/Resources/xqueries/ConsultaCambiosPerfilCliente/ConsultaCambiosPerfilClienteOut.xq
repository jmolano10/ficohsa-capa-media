(:: pragma bea:global-element-parameter parameter="$consultaperfildeclienteResponse" element="ns0:ConsultaperfildeclienteResponse" location="../../xsds/PerfilCliente/XMLSchema_-994245660.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaperfildeclientehistResponse" element="ns0:ConsultaperfildeclientehistResponse" location="../../xsds/PerfilCliente/XMLSchema_-994245660.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaperfildeclienteResponse" location="../../xsds/ConsultaCambiosPerfilCliente/ConsultaCambiosPerfilCliente.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCambiosPerfilCliente/ConsultaCambiosPerfilClienteOut/";

 
(: Se encarga de verificar los cambios entre 2 nodos. Se toma como base la respuesta original($node1).
	Si hay cambio se antepone al valor de cada campo el valor de $cambio, en caso contrario se devuelve el valor original:)
declare function changeProfileField 
  ( $node1 as item()* ,
    $node2 as item()*,
    $cambio as xs:string,
    $tipoPerfil as xs:string)  as item() {

	let $camposActDefecto := 
	if( fn:upper-case($tipoPerfil) = 'LEGAL')then(
		'|NAMEOFBUSINESS|COMMERCIALNAME|RTN|LEGALDOCNAME|LEGALHOLDERNAME|TARGET|TARGETNAME|GENERATORTYPE|CUSTOMERSTATUS|LEGALREPID|LEGALREPNAME|LEGALREPHOMEPHONE|COUNTRYCODE|CUSTOMERCURRENCY|REGISTERDATE|'
	)else(
		'|LEGALID|LEGALDOCNAME|LEGALHOLDERNAME|GIVENNAMES|FAMILYNAMES|DATEOFBIRTH|GENDER|INDUSTRY|INDUSTRYNAME|GENERATORTYPE|TARGET|TARGETNAME|CUSTOMERSTATUS|ADDRESSLINE1|ADDRESSLINE2|SMS|PHONE|EMAIL|'
	)
	let $nombreNodo := fn:concat('|',fn:string(fn:node-name($node1)),'|')
	
	return
		(:Valida si el campo pertenece a lista de actualizacion por defecto:)
		if(fn:contains(data($camposActDefecto), $nombreNodo)) then (
			if (fn:contains($node1/text(),'!!')) then (
				changeProfileFieldMultivalueAlways(fn:string($node1/text()), fn:string($node2/text()), $cambio, "!!")
			
			) else 	if (fn:contains($node1/text(),'||')) then (
				changeProfileFieldMultivalueAlways(fn:string($node1/text()), fn:string($node2/text()), $cambio, "\|\|")
				
			) else (
				fn:concat($cambio, $node1/text())
			)
		) else (
			if (fn:contains($node1/text(),'!!')) then (
				changeProfileFieldMultivalue(fn:string($node1/text()), fn:string($node2/text()), $cambio, "!!")
			
			) else 	if (fn:contains($node1/text(),'||')) then (
				changeProfileFieldMultivalue(fn:string($node1/text()), fn:string($node2/text()), $cambio, "\|\|")
				 
			) else if (fn:deep-equal($node1, $node2)) then (
				fn:string($node1/text())
				
			) else if(fn:string($node1/text()) = "") then (
				$cambio
				
			) else (
				fn:concat($cambio, $node1/text())
			)
		)
 };
 
(: Se encarga de verificar los cambios entre 2 campos multivalores. Se toma como base la respuesta original($node1).
	Si hay cambio se antepone al valor de cada campo el valor de $cambio, en caso contrario se devuelve el valor original:)
declare function changeProfileFieldMultivalue
  ( $node1 as xs:string ,
    $node2 as xs:string,
    $cambio as xs:string,
    $separador)  as xs:string* {
	let $itemsNode1 := tokenize($node1, $separador)
	let $itemsNode2 := tokenize($node2, $separador)	 
	return
		string-join(for $itemNode1 at $i in $itemsNode1 
		return
			if($itemNode1 = $itemsNode2[$i]) then (
				$itemNode1
			)else(
				concat($cambio, $itemNode1)
			), fn:replace($separador,"\\",""))			
		
 };
 
 (:funcion para siempre agregar el prefijo a los campos:)
 declare function changeProfileFieldMultivalueAlways
  ( $node1 as xs:string ,
    $node2 as xs:string,
    $cambio as xs:string,
    $separador)  as xs:string* {
	let $itemsNode1 := tokenize($node1, $separador)
	let $itemsNode2 := tokenize($node2, $separador)	 
	return
		string-join(for $itemNode1 at $i in $itemsNode1 
		return
			concat($cambio, $itemNode1),
			fn:replace($separador,"\\",""))			
		
 };

(: Se encarga se reemplzar el valor de un determinado nodo :)
declare function replace-element-value 
  ( $element as element() ,
    $value as xs:string )  as element() {
       
   element { node-name($element)}
             { $element/@*,
               $value }
 } ;
 
declare function xf:ConsultaCambiosPerfilClienteOut($consultaperfildeclienteResponse as element(ns0:ConsultaperfildeclienteResponse),
    $consultaperfildeclientehistResponse as element(ns0:ConsultaperfildeclientehistResponse))
    as element(ns0:ConsultaperfildeclienteResponse) {
        <ns0:ConsultaperfildeclienteResponse>
            {
                for $Status in $consultaperfildeclienteResponse/Status
                return
                    <Status>{ $Status/@* , $Status/node() }</Status>
            }
		    <WSCUSTOMERFULLType>
		        <gWSCUSTOMERFULLDetailType>
		            <mWSCUSTOMERFULLDetailType>
		             {
		             	let $tipoPerfil := $consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/*[name()='TYPEOFPERSON']/text()
		             
		             	for $item in $consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/*
		             	where fn:string(fn:node-name($item)) != "CURRNO"
		             	let $nodeName := fn:node-name($item)
		             	let $history := $consultaperfildeclientehistResponse/WSCUSTOMERFULLHISTType[1]/gWSCUSTOMERFULLHISTDetailType/mWSCUSTOMERFULLHISTDetailType[1]/*[name()=fn:string($nodeName)]
		             	return
		             		replace-element-value($item, changeProfileField($item, $history, "[-UPD-]", $tipoPerfil))
		             }
		            </mWSCUSTOMERFULLDetailType>
		        </gWSCUSTOMERFULLDetailType>
		    </WSCUSTOMERFULLType>            
        </ns0:ConsultaperfildeclienteResponse>
};

declare variable $consultaperfildeclienteResponse as element(ns0:ConsultaperfildeclienteResponse) external;
declare variable $consultaperfildeclientehistResponse as element(ns0:ConsultaperfildeclientehistResponse) external;

xf:ConsultaCambiosPerfilClienteOut($consultaperfildeclienteResponse,
    $consultaperfildeclientehistResponse)