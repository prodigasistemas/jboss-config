<%@ page session="true" contentType="text/html; charset=ISO-8859-1" %>
<%@ taglib uri="http://www.tonbeller.com/jpivot" prefix="jp" %>
<%@ taglib uri="http://www.tonbeller.com/wcf" prefix="wcf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>




<%--

  JPivot / WCF comes with its own "expression language", which simply
  is a path of properties. E.g. #{customer.address.name} is
  translated into:
    session.getAttribute("customer").getAddress().getName()
  WCF uses jakarta commons beanutils to do so, for an exact syntax
  see its documentation.

  With JSP 2.0 you should use <code>#{}</code> notation to defineres
  expressions for WCF attributes and <code>\${}</code> to define
  JSP EL expressions.

  JSP EL expressions can not be used with WCF tags currently, all
  tag attributes have their <code>rtexprvalue</code> set to false.
  There may be a twin library supporting JSP EL expressions in
  the future (similar to the twin libraries in JSTL, e.g. core
  and core_rt).

  Check out the WCF distribution which contains many examples on
  how to use the WCF tags (like tree, form, table etc).

--%>




<html>
<head>
  <title>GCOM OLAP</title>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="jpivot/table/mdxtable.css">
  <link rel="stylesheet" type="text/css" href="jpivot/navi/mdxnavi.css">
  <link rel="stylesheet" type="text/css" href="wcf/form/xform.css">
  <link rel="stylesheet" type="text/css" href="wcf/table/xtable.css">
  <link rel="stylesheet" type="text/css" href="wcf/tree/xtree.css">
  <link rel="stylesheet" href="css/EstilosCompesa.css" type="text/css">

</head>
<body bgcolor="#CBE5FE">




<table width="100%" border="0"><tr><td>

<%@ include file="cabecalho.jsp"%>


<form action="testpage.jsp" name="form1" method="post">

<%-- include query and title, so this jsp may be used with different queries --%>

<%
String parametro = request.getParameter("parametro");

if (parametro != null) {
	// Verificamos se o usuario selecionou algum Ano de Referencia para o Resumo
	String anoSelecionado = parametro.substring((parametro.length() - 4));
	
	if (anoSelecionado.matches("[0-9]*")) {
		parametro = parametro.substring(0, (parametro.length() - 4));
	}else {
		anoSelecionado = "";
	}
	session.setAttribute("anoselecionado", anoSelecionado);
	session.setAttribute("parametro",parametro);
}

%>




<c:if test="${sessionScope.parametro == 'ResumoLigacaoEconomia'}">
	<h1>Resumo das Liga&ccedil;&otilde;es Economias <% out.write((String)session.getAttribute("anoselecionado")); %></h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoPendenciaSemQuadra'}">
	<h1>Resumo da Pend&ecirc;ncia sem Quadra</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoAnormalidadesConsumo'}">
	<h1>Resumo de Anormalidades de Consumo</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoInstalacaoHidrometro'}">
	<h1>Resumo Hidrometro Instalado/Substituido/Retirado</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoHidrometro'}">
	<h1>Resumo dos Hidr&ocirc;metros n&atilde;o Instalados</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoLeituraAnormalidade'}">
	<h1>Resumo das Leituras e Anormalidades</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoConsumoAgua'}">
	<h1>Resumo do Consumo de &Aacute;gua</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoPendencia'}">
	<h1>Resumo da Pend&ecirc;ncia</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoSituacaoEspecialFaturamento'}">
	<h1>Resumo da Situa&ccedil;&atilde;o Especial de Faturamento</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoFaturamentoCredito'}">
	<h1>Resumo do Faturamento de Cr&eacute;dito</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoFaturamentoOutros'}">
	<h1>Resumo do Faturamento Outros</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoFaturamentoAguaEsgoto'}">
	<h1>Resumo do Faturamento de &Aacute;gua e Esgoto</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoSituacaoEspecialCobranca'}">
	<h1>Resumo da Situacao Especial de Cobran&ccedil;a</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoParcelamento'}">
	<h1>Resumo do Parcelamento</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoArrecadacaoAguaEsgoto'}">
	<h1>Resumo da Arrecada&ccedil;&atilde;o de &Aacute;gua e Esgoto</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoArrecadacaoCredito'}">
	<h1>Resumo do Faturamento de Cr&eacute;dito</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoArrecadacaoOutros'}">
	<h1>Resumo da Arrecada&ccedil;&atilde;o Outros</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoRegistroAtendimento'}">
	<h1>Resumo do Registro de Atendimento</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoArrecadacao'}">
	<h1>Resumo de Arrecada&ccedil;&atilde;o</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoFaturamento'}">
	<h1>Resumo dos Valores Cobrados em Conta</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoIndicadorCobranca'}">
	<h1>Resumo dos Indicadores de Cobranca</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'QuadroAcompanhamentoCobranca'}">
	<h1>Quadro de Acompanhamento da Cobranca</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoIndicadorDesempenhoMicromedicao'}">
	<h1>Indicadores de Desempenho da Micromedi&ccedil;&atilde;o <% out.write((String)session.getAttribute("anoselecionado")); %></h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoIndicadorLigacaoEconomia'}">
	<h1>Indicadores de Desempenho da Comercializa&ccedil;&atilde;o</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'QuadroAcompanhamentoComercializacao'}">
	<h1>Quadro de Acompanhamento da Comercializa&ccedil;&atilde;o</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoIndicadorFaturamento'}">
	<h1>Indicadores de Desempenho do Faturamento</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'QuadroAcompanhamentoFaturamento'}">
	<h1>Quadro de Acompanhamento do Faturamento</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'QuadroAcompanhamentoMicromedicao'}">
	<h1>Quadro de Acompanhamento da Micromedi&ccedil;&atilde;o</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoFaturamentoGerencial'}">
	<h1>Resumo do Faturamento Gerencial</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoCorporativo'}">
	<h1>Resumo Corporativo</h1>
</c:if>

<c:if test="${sessionScope.parametro == 'ResumoColetaEsgoto'}">
	<h1>Resumo Coleta Esgoto</h1>
</c:if>

<wcf:include id="include01" httpParam="query" prefix="/WEB-INF/queries/" suffix=".jsp"/>


<c:if test="${query01 == null}">
	
  <jsp:forward page="/testpage.jsp?query=mondrian&parametro=<%=parametro%>"/>;
   
</c:if>


<%-- define table, navigator and forms --%>
<jp:table id="table01" query="#{query01}"/>
<jp:navigator id="navi01" query="#{query01}" visible="false"/>
<wcf:form id="mdxedit01" xmlUri="/WEB-INF/jpivot/table/mdxedit.xml" model="#{query01}" visible="false"/>
<wcf:form id="sortform01" xmlUri="/WEB-INF/jpivot/table/sortform.xml" model="#{table01}" visible="false"/>


<jp:print id="print01"/>
<wcf:form id="printform01" xmlUri="/WEB-INF/jpivot/print/printpropertiesform.xml" model="#{print01}" visible="false"/>

<jp:chart id="chart01" query="#{query01}" visible="false"/>
<wcf:form id="chartform01" xmlUri="/WEB-INF/jpivot/chart/chartpropertiesform.xml" model="#{chart01}" visible="false"/>
<wcf:table id="query01.drillthroughtable" visible="false" selmode="none" editable="true"/>

<%--<h2><c:out value="${title01}"/></h2>--%>

<%-- define a toolbar --%>
<wcf:toolbar id="toolbar01" bundle="com.tonbeller.jpivot.toolbar.resources">
  <wcf:scriptbutton id="cubeNaviButton" tooltip="toolb.cube" img="cube" model="#{navi01.visible}"/>
  <wcf:scriptbutton id="mdxEditButton" tooltip="toolb.mdx.edit" img="mdx-edit" model="#{mdxedit01.visible}"/>
  <wcf:scriptbutton id="sortConfigButton" tooltip="toolb.table.config" img="sort-asc" model="#{sortform01.visible}"/>
  <wcf:separator/>
<%--  <wcf:scriptbutton id="levelStyle" tooltip="toolb.level.style" img="level-style" model="#{table01.extensions.axisStyle.levelStyle}"/>--%>
<%--  <wcf:scriptbutton id="hideSpans" tooltip="toolb.hide.spans" img="hide-spans" model="#{table01.extensions.axisStyle.hideSpans}"/>--%>
<%--  <wcf:scriptbutton id="propertiesButton" tooltip="toolb.properties"  img="properties" model="#{table01.rowAxisBuilder.axisConfig.propertyConfig.showProperties}"/>--%>
  <wcf:scriptbutton id="nonEmpty" tooltip="toolb.non.empty" img="non-empty" model="#{table01.extensions.nonEmpty.buttonPressed}"/>
  <wcf:scriptbutton id="swapAxes" tooltip="toolb.swap.axes"  img="swap-axes" model="#{table01.extensions.swapAxes.buttonPressed}"/>

  <wcf:separator/>

  <wcf:scriptbutton model="#{table01.extensions.drillMember.enabled}"	 tooltip="toolb.navi.member" radioGroup="navi" id="drillMember"   img="navi-member"/>
  <wcf:scriptbutton model="#{table01.extensions.drillPosition.enabled}" tooltip="toolb.navi.position" radioGroup="navi" id="drillPosition" img="navi-position"/>
  <wcf:scriptbutton model="#{table01.extensions.drillReplace.enabled}"	 tooltip="toolb.navi.replace" radioGroup="navi" id="drillReplace"  img="navi-replace"/>
  <wcf:scriptbutton model="#{table01.extensions.drillThrough.enabled}"  tooltip="toolb.navi.drillthru" id="drillThrough01"  img="navi-through"/>
  <wcf:separator/>
  <wcf:scriptbutton id="chartButton01" tooltip="toolb.chart" img="chart" model="#{chart01.visible}"/>
  <wcf:scriptbutton id="chartPropertiesButton01" tooltip="toolb.chart.config" img="chart-config" model="#{chartform01.visible}"/>
  <wcf:separator/>
  <wcf:scriptbutton id="printPropertiesButton01" tooltip="toolb.print.config" img="print-config" model="#{printform01.visible}"/>
  <wcf:imgbutton id="printpdf" tooltip="toolb.print" img="print" href="./Print?cube=01&type=1"/>
  <wcf:imgbutton id="printxls" tooltip="toolb.excel" img="excel" href="./Print?cube=01&type=0"/>
</wcf:toolbar>

<%-- render toolbar --%>
<wcf:render ref="toolbar01" xslUri="/WEB-INF/jpivot/toolbar/htoolbar.xsl" xslCache="true"/>

<p>

<%-- if there was an overflow, show error message --%>
<c:if test="${query01.result.overflowOccured}">
  <p>
  <strong style="color:red">Resultset overflow occured</strong>
  <p>
</c:if>

<%-- render navigator --%>
<wcf:render ref="navi01" xslUri="/WEB-INF/jpivot/navi/navigator.xsl" xslCache="true"/>

<%-- edit mdx --%>
<c:if test="${mdxedit01.visible}">
  <h3>MDX Query Editor</h3>
  <wcf:render ref="mdxedit01" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>
</c:if>


<%-- sort properties --%>
<wcf:render ref="sortform01" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>

<%-- chart properties --%>
<wcf:render ref="chartform01" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>

<%-- print properties --%>
<wcf:render ref="printform01" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>

<!-- render the table -->
<p>
<wcf:render ref="table01" xslUri="/WEB-INF/jpivot/table/mdxtable.xsl" xslCache="true"/>
<p>
Slicer:
<wcf:render ref="table01" xslUri="/WEB-INF/jpivot/table/mdxslicer.xsl" xslCache="true"/>

<p>
<!-- drill through table -->
<wcf:render ref="query01.drillthroughtable" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>

<p>
<!-- render chart -->
<wcf:render ref="chart01" xslUri="/WEB-INF/jpivot/chart/chart.xsl" xslCache="true"/>



<c:if test="${sessionScope.parametro == 'ResumoIndicadorDesempenhoMicromedicao'}">

<br><p><span style="font-weight: bold; text-decoration: underline;">F&oacute;rmulas dos Indicadores:</span></p>
<p><font size="2">
<strong>&Iacute;ndice de Hidrometra&ccedil;&atilde;o Faturado(%): </strong>(Liga&ccedil;&otilde;es Ativas com Hidr&ocirc;metro / Liga&ccedil;&otilde;es Ativas) * 100 <br>
<!--<strong>&Iacute;ndice de Medi&ccedil;&atilde;o de Consumo - Efetivo (%):</strong> (Liga&ccedil;&otilde;es com Medi&ccedil;&atilde;o Real / Liga&ccedil;&otilde;es Ativas) * 100 <br>-->
<strong>Efici&ecirc;ncia da Medi&ccedil;&atilde;o de Consumo (%)</strong>: (Liga&ccedil;&otilde;es com Medi&ccedil;&atilde;o Real / Liga&ccedil;&otilde;es Ativas com Hidr&ocirc;metro) * 100<br>
<strong>Efici&ecirc;ncia da Leitura (%)</strong>: (Leituras Efetuadas / Visitas Realizadas) * 100 <br>
<strong>Hidr&ocirc;metros com Anormalidade (%)</strong>: (Liga&ccedil;&otilde;es com Anormalidade de Hidr&ocirc;metro / Liga&ccedil;&otilde;es Ativas com Hidr&ocirc;metro) * 100 <br>
<strong>Volume M&eacute;dio das Liga&ccedil;&otilde;es com Hidr&ocirc;metro - Consumo Real (m&sup3;)</strong>: Volume com Medi&ccedil;&atilde;o Real / Liga&ccedil;&otilde;es com Medi&ccedil;&atilde;o Real <br>
<!--<strong>Volume M&eacute;dio das Liga&ccedil;&otilde;es com Hidr&ocirc;metro - Consumo Estimado (m&sup3;)</strong>: Volume com Medi&ccedil;&atilde;o Estimada / Liga&ccedil;&otilde;es com Hidr&ocirc;metro e Medi&ccedil;&atilde;o Estimada <br>-->
<strong>Volume Consumido por Liga&ccedil;&atilde;o (m&sup3;)</strong>: Volume Total Consumido / Liga&ccedil;&otilde;es Ativas <br>
<strong>Volume Consumido por Economia (m&sup3;)</strong>: Volume Total Consumido / Economias Ativas<strong></strong> <br>
<strong>Percentual de Volume com Hidr&ocirc;metro - Consumo Real (%)</strong>: (Volume com Medi&ccedil;&atilde;o Real * 100) / (Volume com Medi&ccedil;&atilde;o Real +Volume com Medi&ccedil;&atilde;o Estimada) <br>
<strong>Percentual de Volume com Hidr&ocirc;metro - Consumo Estimado (%):</strong> (Volume com Medi&ccedil;&atilde;o Estimada * 100) / (Volume com Medi&ccedil;&atilde;o Real + Volume com Medi&ccedil;&atilde;o Estimada)
</font></p>

</c:if>

<c:if test="${sessionScope.parametro == 'ResumoIndicadorLigacaoEconomia'}">

<br><p><span style="font-weight: bold; text-decoration: underline;">F&oacute;rmulas dos Indicadores:</span></p>
<p><font size="2">
<strong>&Iacute;ndice de Crescimento de Liga&ccedil;&otilde;es &Aacute;gua (%):</strong> ( Liga&ccedil;&otilde;es Ativas &Aacute;gua -&nbsp;Liga&ccedil;&otilde;es Ativas &Aacute;gua M&ecirc;s Anterior) * 100 / (Liga&ccedil;&otilde;es Ativas &Aacute;gua M&ecirc;s Anterior) <br>
<strong>&Iacute;ndice de Crescimento de Liga&ccedil;&otilde;es Esgoto (%):</strong> (Liga&ccedil;&otilde;es Ativas Esgoto - Liga&ccedil;&otilde;es Ativas Esgoto M&ecirc;s Anterior) * 100&nbsp; / (Liga&ccedil;&otilde;es Ativas Esgoto M&ecirc;s Anterior) <br>
<strong>&Iacute;ndice de Crescimento de Economias &Agrave;gua (%):</strong> (Economias Totais &Agrave;gua - Economias Totais &Aacute;gua M&ecirc;s Anterior) ) *&nbsp;100 / (Economias Totais &Aacute;gua M&ecirc;s Anterior) <br>
<strong>&Iacute;ndice de Crescimento de Economias Esgoto (%):</strong> (Economias Totais Esgoto - Economias Totais Esgoto M&ecirc;s Anterior) * 100 / (Economias Totais Esgoto M&ecirc;s Anterior)
</font></p>
<p><font size="2">
<strong>Economias Totais =</strong> Economias cuja situa&ccedil;&atilde;o de &aacute;gua e esgoto s&atilde;o diferentes de "Potencial" e "Fact&iacute;vel"
</font></p>

</c:if>

<c:if test="${sessionScope.parametro == 'QuadroAcompanhamentoFaturamento'}">

<br><p><span style="font-weight: bold; text-decoration: underline;">Legenda:</span></p>
<p><font size ="2">
<strong>Valor de Outros Servi&ccedil;os Indiretos:</strong> (Valor Faturado de Outros Documentos - Valor de Acr&eacute;scimos por Impontualidade)<br />
<strong>Faturamento Gerencial Bruto:</strong> (Valor de &Aacute;gua + Valor de Esgoto + Valor de Acr&eacute;scimos por Impontualidade + Valor de Outros Servi&ccedil;os Indiretos)<br />
<strong>Quantidade de Contas Refaturadas:</strong> (Quantidade de Contas Retificadas + Quantidade de Contas Canceladas + Quantidade de Contas Inclu&iacute;das)<br />
<strong>Valor Cancelado por Refaturamento:</strong> (Valor Cancelado de &Aacute;gua - Valor Inclu&iacute;do de &Aacute;gua) + (Valor Cancelado de Esgoto - Valor Inclu&iacute;do de Esgoto) + (Valor Cancelado de Outros Documentos - Valor Inclu&iacute;do de Outros Documentos)<br />
<strong>Quantidade de Contas do L&iacute;quido Gerencial:</strong> (Quantidade de Contas Emitidas - Quantidade de Contas Canceladas + Quantidade de Contas Inclu&iacute;das) <br />
<strong>Faturamento Gerencial L&iacute;quido:</strong> (Faturamento Gerencial Bruto - Valor Cancelado por Refaturamento) <br />
<strong>Total Cobrado:</strong> (Faturamento Gerencial L&iacute;quido + Parcelamentos Cobrados + Arrastos Cobrados)
</font></p>

</c:if>

<c:if test="${sessionScope.parametro == 'ResumoIndicadorFaturamento'}">

<br><p><span style="font-weight: bold; text-decoration: underline;">Legenda:</span></p>
<p><font size ="2">
<strong>&Iacute;ndice de Evolu&ccedil;&aacute;o do Faturamento - Quantidade de Contas (%):</strong> (Quantidade de Contas Faturamento L&iacute;quido - Quantidade de Contas Faturamento L&iacute;quido M&ecirc;s Anterior) / (Quantidade de Contas Faturamento L&iacute;quido M&ecirc;s Anterior) * 100 <br />
<strong>&Iacute;ndice de Evolu&ccedil;&aacute;o do Faturamento - Valor do Faturamento L&iacute;quido (%):</strong> (Valor do Faturamento L&iacute;quido - Valor do Faturamento L&iacute;quido M&ecirc;s Anterior) / (Valor do Faturamento L&iacute;quido M&ecirc;s Anterior) * 100 <br />
<strong>Faturamento M&eacute;dio por Conta (R$):</strong> (Valor do Faturamento L&iacute;quido) / (Quantidade de Contas do Faturamento L&iacute;quido)<br />
<strong>Faturamento M&eacute;dio por Economia (R$):</strong> (Valor do Faturamento L&iacute;quido) / (Quantidade de Economias Faturadas)<br />
<strong>Tarifa M&eacute;dia de &Aacute;gua (R$):</strong> (Valor do Faturamento L&iacute;quido de &Aacute;gua) / (Volume do Faturamento L&iacute;quido de &Aacute;gua)<br />
<strong>Tarifa M&eacute;dia de Esgoto (R$):</strong> (Valor do Faturamento L&iacute;quido de Esgoto) / (Volume do Faturamento L&iacute;quido de Esgoto)<br />
<strong>&Iacute;ndice de Refaturamento – Quantidade de Contas (%):</strong> (Quantidade de Contas Refaturadas / Quantidade de Contas emitidas no Faturamento Original) * 100<br />
<strong>&Iacute;ndice de Refaturamento – Valor do Faturamento (%):</strong> ((Valor do Faturamento Original - Valor do Faturamento L&iacute;quido) / (Valor do Faturamento Original)) * 100
</font></p>

</c:if>


<%--<input type="button" class="bottonRightCol" value="Voltar" style="width: 80px"
onclick="javascript:window.location.href = 'http://www.compesa.com.br/gcom/exibirSelecionarRelatorioGerencialAction.do'" />
<a href="http://www.compesa.com.br/gcom/exibirSelecionarRelatorioGerencialAction.do">Voltar</a>--%>

</td></tr></table>

</form>


</body>
</html>










