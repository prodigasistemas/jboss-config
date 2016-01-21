<%@ page session="true" contentType="text/html; charset=ISO-8859-1" %>
<%@ taglib uri="http://www.tonbeller.com/jpivot" prefix="jp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>

<jp:mondrianQuery queryName="QuadroAcompanhamentoCobranca" dynLocale="pt"
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">


select NON EMPTY {[AnoMesReferencia].[Todos]} ON COLUMNS,
		NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Categorias.categoria].[Todas]}, {[Measures].[Quantidade de Faturas Arrecadadas], [Measures].[Valor Total Arrecadado], [Measures].[Valor Arrecadado de Parcelamento], [Measures].[Quantidade de Ligacoes Ativas com Contas a Receber], [Measures].[Quantidade Total de Ligacoes com Contas a Receber], [Measures].[Quantidade de Documentos a Receber], [Measures].[Valor a Receber de Parcelamento a Cobrar], [Measures].[Valor a Receber de Servicos a Cobrar], [Measures].[Valor Total a Receber], [Measures].[Cortes Realizados], [Measures].[Supressoes Realizadas], [Measures].[Religacoes Realizadas], [Measures].[Reestabelecimentos Realizados], [Measures].[Quantidade de Parcelamentos Realizados], [Measures].[Quantidade de Documentos Parcelados], [Measures].[Parcelamento Valor Negociado], [Measures].[Parcelamento Valor Financiado], [Measures].[Parcelamento Valor Total Parcelado], [Measures].[Quantidade de Ligacoes Nao Ativas com Contas a Receber], [Measures].[Valor a Receber de Documentos]}))) ON ROWS
		from [QuadroAcompanhamentoCobranca]

</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoIndicadorCobranca" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia].[Todos]} ON COLUMNS,
		NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Categorias.categoria].[Todas]}, {[Measures].[Indice de Evolucao da Pendencia Contas Pendentes], [Measures].[Indice de Evolucao da Pendencia Valor da Pendencia], [Measures].[Percentual da Arrecadacao Contas Recebidas], [Measures].[Percentual da Arrecadacao Valor do Faturamento], [Measures].[Indice de Recebimento No Mes Ate o Venc], [Measures].[Indice de Recebimento No Mes Apos o Venc], [Measures].[Indice de Recebimento No Segundo Mes], [Measures].[Indice de Recebimento No Terceiro Mes], [Measures].[Indice de Recebimento Ate Terceiro Mes], [Measures].[Indice de Ligacoes Inativas Cortadas], [Measures].[Indice de Ligacoes Inativas Suprimidas]}))) ON ROWS
		from [ResumoIndicadorCobranca]

</jp:mondrianQuery>


<jp:mondrianQuery queryName="ResumoLigacaoEconomia" dynLocale="pt"
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml" stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[Categorias.categoria].[Todas]}, Crossjoin({[LigacoesAguaSituacao.ligacaoAguaSituacao].[Todas]}, Crossjoin({[LigacoesEsgotoSituacao.ligacaoEsgotoSituacao].[Todas]}, {[Measures].[Quantidade Ligações de Cadastro], [Measures].[Quantidade Economias de Cadastro]}))) ON ROWS
from [ResumoLigacaoEconomia]

</jp:mondrianQuery>

<%--<jp:mondrianQuery queryName="ResumoLigacaoEconomia2008" dynLocale="pt"
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml" stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[Categorias.categoria].[Todas]}, Crossjoin({[LigacoesAguaSituacao.ligacaoAguaSituacao].[Todas]}, Crossjoin({[LigacoesEsgotoSituacao.ligacaoEsgotoSituacao].[Todas]}, {[Measures].[Quantidade Ligações de Cadastro], [Measures].[Quantidade Economias de Cadastro]}))) ON ROWS
from [ResumoLigacaoEconomia2008]

</jp:mondrianQuery> --%>
<%--
<jp:mondrianQuery queryName="ResumoLigacaoEconomia2008" dynLocale="pt"
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml" stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[Categorias.categoria].[Todas]}, Crossjoin({[LigacoesAguaSituacao.ligacaoAguaSituacao].[Todas]}, Crossjoin({[LigacoesEsgotoSituacao.ligacaoEsgotoSituacao].[Todas]}, {[Measures].[Quantidade Ligações], [Measures].[Quantidade Economias]}))) ON ROWS
from [ResumoLigacaoEconomia2008]

</jp:mondrianQuery>
--%>
<jp:mondrianQuery queryName="ResumoConsumoAgua" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml" stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Categorias.categoria].[Todas]}, {[Measures].[Quantidade Ligações], [Measures].[Quantidade Economias], [Measures].[ConsumoMinimo], [Measures].[Consumo Excedente], [Measures].[Consumo Total Cobrado], [Measures].[Volume Faturado]})) ON ROWS
from [ResumoConsumoAgua]

</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoLeituraAnormalidade" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY {([GerenciasRegionais.gerenciaRegional].[Todas], [Localidades.localidade].[Todas], [LeituraAnormalidade.leituraAnormalidade].[Todos])} ON ROWS
from [ResumoLeituraAnormalidade]


</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoHidrometro" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {([Measures].[Quantidade Hidrometros], [AnoMesReferencia.anoMesReferencia])} ON COLUMNS,
  NON EMPTY {([LocalArmazanagem.localArmazenagem].[Todos], [HidrometroMarca.hidrometroMarca].[Todas], [HidrometroSituacao.hidrometroSituacao].[Todas])} ON ROWS
from [ResumoHidrometro]

</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoInstalacaoHidrometro" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, {[Measures].[Instalados no Ramal], [Measures].[Substituidos no Ramal], [Measures].[Retirados do Ramal], [Measures].[Instalados no Poco], [Measures].[Substituidos no Poco], [Measures].[Retirados do Poco], [Measures].[Total Instalados no Ramal], [Measures].[Total Instalados no Poco]})) ON ROWS
from [ResumoInstalacaoHidrometro]
</jp:mondrianQuery>


<jp:mondrianQuery queryName="ResumoParcelamento" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia.anoMesReferencia].[Todas]} ON COLUMNS,
		NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Categorias.categoria].[Todas]}, {[Measures].[Quantidade Parcelamentos], [Measures].[Quantidade Contas], [Measures].[Valor Contas], [Measures].[Quantidade Guias], [Measures].[Valor Guias], [Measures].[Valor Debitos a Cobrar Parcelamento], [Measures].[Valor Creditos], [Measures].[Valor Acrescimo Impontualidade], [Measures].[Valor Descontos de Acrescimo], [Measures].[Valor Descontos por Inatividade], [Measures].[Valor Descontos por Antiguidade], [Measures].[Valor Outros Descontos], [Measures].[Valor Negociado], [Measures].[Valor de Entrada], [Measures].[Entrada Parcelamento], [Measures].[Valor Financiado], [Measures].[Valor de Juros], [Measures].[Valor Parcelado], [Measures].[Quantidade Media de Parcelas], [Measures].[Valor Medio Parcelas]}))) ON ROWS
		from [ResumoParcelamento]

</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoArrecadacao" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Categorias.categoria].[Todas]}, Crossjoin({[ImoveisPerfil.imovelPerfil].[Todos]}, Crossjoin({[DocumentoTipo.documentoTipo].[Todos]}, {[Measures].[Quantidade Contas], [Measures].[Valor Agua], [Measures].[Valor Esgoto], [Measures].[Valor Documentos Recebidos Outros], [Measures].[Valor Documentos Recebidos Credito], [Measures].[Valor Nao Identificado], [Measures].[Valor Impostos], [Measures].[Total das Devoluções], [Measures].[Total do Valor de Pagamentos], [Measures].[Arrecadação Líquida]}))))) ON ROWS
from [ResumoArrecadacao]


<%--
<jp:mondrianQuery queryName="ResumoFaturamentoOutros" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[Measures].[Quantidade Documentos Faturados], [Measures].[Valor Documentos Faturados]} ON COLUMNS,
  NON EMPTY Crossjoin({[DocumentoTipo]}, Crossjoin({[FinanciamentoTipo]}, {[LancamentoItemContabil]})) ON ROWS
from [ResumoFaturamentoOutros] 
</jp:mondrianQuery> --%>


<%--<jp:mondrianQuery queryName="ResumoFaturamentoCredito" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[Measures].[Quantidade Documentos Faturados], [Measures].[Valor Documentos Faturados]} ON COLUMNS,
  NON EMPTY Crossjoin({[LancamentoItemContabil]}, {[CreditoOrigem]}) ON ROWS
from [ResumoFaturamentoCredito] 
</jp:mondrianQuery>--%>

<%--<jp:mondrianQuery queryName="ResumoFaturamentoAguaEsgoto" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[Measures].[Quantidade Contas Emitidas], [Measures].[Valor Faturado Agua], [Measures].[Valor Faturado Esgoto], [Measures].[Volume Faturado Agua], [Measures].[Volume Faturado Esgoto]} ON COLUMNS,
  NON EMPTY Crossjoin({[AnoMesReferencia]}, Crossjoin({[GerenciasRegionais]}, Crossjoin({[Localidades]}, Crossjoin({SetoresComerciais}, Crossjoin({Quadras}, Crossjoin({Categorias}, Crossjoin({LigacoesAguaSituacao}, {LigacoesEsgotoSituacao}))))))) ON ROWS
from [ResumoFaturamentoAguaEsgoto] 
</jp:mondrianQuery>--%>

<jp:mondrianQuery queryName="ResumoArrecadacaoAguaEsgoto" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[Measures].[Quantidade Contas], [Measures].[Valor Agua], [Measures].[Valor Esgoto], [Measures].[Valor Nao Identificado]} ON COLUMNS,
  NON EMPTY Crossjoin({[AnoMesReferencia]}, Crossjoin({[GerenciasRegionais]}, Crossjoin({[Localidades]}, Crossjoin({SetoresComerciais}, Crossjoin({Quadras}, Crossjoin({Categorias}, Crossjoin({LigacoesAguaSituacao}, {LigacoesEsgotoSituacao}))))))) ON ROWS
from [ResumoArrecadacaoAguaEsgoto] 
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoArrecadacaoCredito" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[Measures].[Valor Documentos Recebidos]} ON COLUMNS,
  NON EMPTY Crossjoin({CreditoOrigem}, {LancamentoItemContabil}) ON ROWS
from [ResumoArrecadacaoCredito] 
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoArrecadacaoOutros" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[Measures].[Valor Documentos Recebidos]} ON COLUMNS,
  NON EMPTY Crossjoin({FinanciamentoTipo}, {LancamentoItemContabil}) ON ROWS
from [ResumoArrecadacaoOutros] 
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoFaturamento" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, {[Measures].[Quantidade Contas Emitidas], [Measures].[Quantidade de Economias Faturadas], [Measures].[Valor Faturado Agua], [Measures].[Valor Faturado Esgoto], [Measures].[Valor Documentos Faturados Outros], [Measures].[Valor Documentos Faturados Credito], [Measures].[Total Cobrado nas Contas]})) ON ROWS
from [ResumoFaturamento]
</jp:mondrianQuery>



</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoRegistroAtendimento" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[SolicitacaoTipo]}, Crossjoin({[SolicitacaoTipoEspecificacao]}, {[Measures].[Quantidade RAs Geradas], [Measures].[Quantidade RAS Pendentes no Prazo], [Measures].[Quantidade RAS Pendentes Fora do Prazo], [Measures].[Quantidade RAS Encerradas no Prazo], [Measures].[Quantidade RAS Encerradas Fora do Prazo]})))) ON ROWS
from [ResumoRegistroAtendimento]
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoIndicadorLigacaoEconomia" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.Mesreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]},Crossjoin({[Measures].[Indice de Crescimento de Ligacoes Agua(%)], [Measures].[Indice de Crescimento de Ligacoes Esgoto(%)], [Measures].[Indice de Crescimento de Economias Agua(%)], [Measures].[Indice de Crescimento de Economias Esgoto(%)]}, {[AnoReferencia.Anoreferencia].[Todos]}))) ON ROWS
from [ResumoIndicadorLigacaoEconomia]
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoIndicadorLigacaoEconomia2007" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.Mesreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]},Crossjoin({[Measures].[Indice de Crescimento de Ligacoes Agua(%)], [Measures].[Indice de Crescimento de Ligacoes Esgoto(%)], [Measures].[Indice de Crescimento de Economias Agua(%)], [Measures].[Indice de Crescimento de Economias Esgoto(%)]}, {[AnoReferencia.Anoreferencia].[Todos]}))) ON ROWS
from [ResumoIndicadorLigacaoEconomia2007]
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoIndicadorFaturamento" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.Mesreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Measures].[Indice de Evolucao do Faturamento Quantidade de Contas], [Measures].[Indice de Evolucao do Faturamento Valor do Faturamento Liquido], [Measures].[Faturamento Medio por Conta], [Measures].[Faturamento Medio por Economia], [Measures].[Tarifa Media de Agua], [Measures].[Tarifa Media de Esgoto], [Measures].[Indice de Refaturamento Quantidade de Contas], [Measures].[Indice de Refaturamento Valor do Faturamento]}, {[AnoReferencia.Anoreferencia].[Todos]}))) ON ROWS
from [ResumoIndicadorFaturamento]
</jp:mondrianQuery>




<jp:mondrianQuery queryName="QuadroAcompanhamentoComercializacao" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.Mesreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Measures].[Clientes de Agua Potenciais e Factiveis], [Measures].[Clientes de Agua Ligados e Cortados], [Measures].[Clientes de Agua Suprimidos], [Measures].[Economias de Agua Potenciais e Factiveis], [Measures].[Economias de Agua Ligados e Cortados], [Measures].[Economias de Agua Suprimidas], [Measures].[Clientes de Esgoto Potenciais e Factiveis], [Measures].[Clientes de Esgoto Ligados], [Measures].[Clientes de Esgoto Fora de Uso], [Measures].[Economias de Esgoto Potenciais e Factiveis], [Measures].[Economias de Esgoto Ligados], [Measures].[Economias de Esgoto Ligados Fora de Uso]}, {[AnoReferencia.Anoreferencia].[Todos]}))) ON ROWS
from [QuadroAcompanhamentoComercializacao]
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoPendencia" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[Categorias.categoria].[Todas]}, Crossjoin({[LigacoesAguaSituacao.ligacaoAguaSituacao].[Todas]}, Crossjoin({[LigacoesEsgotoSituacao.ligacaoEsgotoSituacao].[Todas]}, {[Measures].[Quantidade de Documentos], [Measures].[Valor Pendente de Agua], [Measures].[Valor Pendente de Esgoto], [Measures].[Valor Pendente de Debitos], [Measures].[Valor Pendente de Creditos], [Measures].[Valor Pendente de Impostos], [Measures].[ValorTotalPendente]}))) ON ROWS
from [ResumoPendencia]
</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoPendenciaSemQuadra" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
  NON EMPTY Crossjoin({[Categorias.categoria].[Todas]}, Crossjoin({[LigacoesAguaSituacao.ligacaoAguaSituacao].[Todas]}, Crossjoin({[LigacoesEsgotoSituacao.ligacaoEsgotoSituacao].[Todas]}, {[Measures].[Quantidade de Documentos], [Measures].[Valor Pendente de Agua], [Measures].[Valor Pendente de Esgoto], [Measures].[Valor Pendente de Debitos], [Measures].[Valor Pendente de Creditos], [Measures].[Valor Pendente de Impostos], [Measures].[ValorTotalPendente]}))) ON ROWS
from [ResumoPendenciaSemQuadra]
</jp:mondrianQuery>


<jp:mondrianQuery queryName="ResumoIndicadorDesempenhoMicromedicao" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.Mesreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Measures].[Indice de Hidrometracao Faturado(%)], [Measures].[Eficiencia da Medicao de Consumo(%)], [Measures].[Eficiencia da Leitura(%)], [Measures].[Hidrometros com Anormalidade(%)], [Measures].[Volume Medio das Ligacoes com Hidrometro - Consumo Real(M3)], [Measures].[Volume Consumido por Ligacao(M3)], [Measures].[Volume Consumido por Economia(M3)], [Measures].[Percentual de Volume com Hidrometro - Consumo Real(%)], [Measures].[Percentual de Volume com Hidrometro - Consumo Estimado(%)]}, {[AnoReferencia.Anoreferencia].[Todos]}))) ON ROWS
from [ResumoIndicadorDesempenhoMicromedicao]
</jp:mondrianQuery>

<jp:mondrianQuery queryName="QuadroAcompanhamentoMicromedicao" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.Mesreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Measures].[Economias Faturadas Agua Sem Hidrometro], [Measures].[Quantidade Economias com Hidrometro], [Measures].[Quantidade Economias Ativas], [Measures].[Ligacoes Agua Sem Hidrometro], [Measures].[Quantidade Ligacoes com Hidrometro], [Measures].[Quantidade Ligacoes Ativas], [Measures].[Quantidade Leituras Efetuadas], [Measures].[Quantidade Ligacoes com Medicao Real], [Measures].[Instalados no Ramal], [Measures].[Instalados no Poco], [Measures].[Hidrometros Instalados Total], [Measures].[Substituidos no Ramal], [Measures].[Substituidos no Poco], [Measures].[Hidrometros Substituidos Total], [Measures].[Volume Consumo Agua com Medicao Real], [Measures].[Volume Consumo Agua com Hidrometro e Medicao Estimada], [Measures].[Volume com Hidrometro Total], [Measures].[Volume Faturado Agua Medido], [Measures].[Volume Faturado Agua Nao Medido], [Measures].[Volume Faturado de Agua], [Measures].[Volume Faturado Esgoto Medido], [Measures].[Volume Faturado Esgoto Nao Medido], [Measures].[Volume Faturado Esgoto Total]}, {[AnoReferencia.Anoreferencia].[Todos]}))) ON ROWS
from [QuadroAcompanhamentoMicromedicao]
</jp:mondrianQuery>

<jp:mondrianQuery queryName="QuadroAcompanhamentoFaturamento" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.Mesreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Measures].[Quantidade de Contas Emitidas], [Measures].[Valor Faturado de Agua], [Measures].[Valor Faturado de Esgoto], [Measures].[Valor Faturado de Acrescimo por Impontualidade], [Measures].[Valor de Outros Servicos Indiretos], [Measures].[Faturamento Total], [Measures].[Quantidade de Contas Refaturadas], [Measures].[Valor Cancelado no Refaturamento], [Measures].[Quantidade de Contas do Liquido Gerencial], [Measures].[Faturamento Liquido], [Measures].[Valor de Parcelamento de Debitos], [Measures].[Valor de Arrastos], [Measures].[Total Cobrado]}, {[AnoReferencia.Anoreferencia].[Todos]}))) ON ROWS
from [QuadroAcompanhamentoFaturamento]
</jp:mondrianQuery>

<%--
<jp:mondrianQuery queryName="ResumoFaturamentoGerencial" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoReferencia.Anoreferencia].[Todos]} ON COLUMNS,
  NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, {[Measures].[Valor Faturado Agua], [Measures].[Valor Faturado Esgoto], [Measures].[Valor Documentos Faturados Outros], [Measures].[Valor Documentos Faturados Credito], [Measures].[Valor de Imposto], [Measures].[Valor Incluido de Agua], [Measures].[Valor Incluido de Esgoto], [Measures].[Valor Incluido Outros], [Measures].[Valor Incluido Credito], [Measures].[Valor Impostos Incluidos], [Measures].[Valor Cancelado de Agua], [Measures].[Valor Cancelado de Esgoto], [Measures].[Valor Cancelado de Outros], [Measures].[Valor Cancelado Credito], [Measures].[Valor Impostos Cancelados], [Measures].[Arrecadacao Total], [Measures].[Quantidade Documentos Faturados], [Measures].[Quantidade Documentos Incluidos], [Measures].[Quantidade Documentos Cancelados], [Measures].[Quantidade Documentos Retificados], [Measures].[Valor Faturamento Bruto], [Measures].[Valor Inclusoes Refaturamento], [Measures].[Valor Cancelamentos Refaturamento], [Measures].[Faturamento Liquido Gerencial], [Measures].[Arrecadacao Sobre Faturamento Liquido], [Measures].[Quantidade Documentos Faturamento Liquido], [Measures].[Documentos Arrecadados Sobre Faturados], [Measures].[Quantidade Documentos Arrecadados]})) ON ROWS
from [ResumoFaturamentoGerencial]

</jp:mondrianQuery>

<jp:mondrianQuery queryName="ResumoCorporativo" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[MesReferencia.MesReferencia].[Total], [MesReferencia.MesReferencia].[Total].[01-Jan], [MesReferencia.MesReferencia].[Total].[02-Fev], [MesReferencia.MesReferencia].[Total].[03-Mar], [MesReferencia.MesReferencia].[Total].[04-Abr], [MesReferencia.MesReferencia].[Total].[05-Mai], [MesReferencia.MesReferencia].[Total].[06-Jun], [MesReferencia.MesReferencia].[Total].[07-Jul], [MesReferencia.MesReferencia].[Total].[08-Ago], [MesReferencia.MesReferencia].[Total].[09-Set], [MesReferencia.MesReferencia].[Total].[10-Out], [MesReferencia.MesReferencia].[Total].[11-Nov], [MesReferencia.MesReferencia].[Total].[12-Dez]} ON COLUMNS,
  NON EMPTY Crossjoin({[Measures].[ValorFaturamentoLiquido], [Measures].[ValorArrecadação], [Measures].[ValorFaturamentoAgua], [Measures].[ValorFaturamentoEsgoto], [Measures].[IndiceAdimplencia], [Measures].[VolumeFaturado], [Measures].[VolumeConsumido], [Measures].[QuantidadeRamaisLigRamaisLigAnalise], [Measures].[QuantidadeRamaisCortados], [Measures].[QuantidadeLigacoesAtivas], [Measures].[QuantidadeLigacoesInativas], [Measures].[LigaçõesMedidas], [Measures].[QuantidadeLigacoesNaoMedidas], [Measures].[QuantidadeHidrometroInstalado]}, {[AnoReferencia.AnoReferencia].[Total], [AnoReferencia.AnoReferencia].[Total].[2006], [AnoReferencia.AnoReferencia].[Total].[2007], [AnoReferencia.AnoReferencia].[Total].[2008]}) ON ROWS
from [ResumoCorporativo]
</jp:mondrianQuery>
--%>
<jp:mondrianQuery queryName="ResumoColetaEsgoto" dynLocale="pt"
	jdbcDriver="org.postgresql.Driver" 
	dataSource="java:/PostgresGerencialDS"
	catalogUri="/WEB-INF/queries/schemaGcomGerencial2.xml"  stackMode="true" id="query01">

select NON EMPTY {[AnoMesReferencia]} ON COLUMNS,
		NON EMPTY Crossjoin({[GerenciasRegionais.gerenciaRegional].[Todas]}, Crossjoin({[Localidades.localidade].[Todas]}, Crossjoin({[Categorias.categoria].[Todas]}, Crossjoin({[ImoveisPerfil.imovelPerfil].[Todos]}, {[Measures].[Quantidade Economias], [Measures].[Volume Esgoto], [Measures].[Quantidade de Ligacoes], [Measures].[Consumo Excedente], [Measures].[Consumo Faturado Mes]})))) ON ROWS
		from [ResumoColetaEsgoto]

</jp:mondrianQuery>



<%--<c:set var="parametro" scope="request">ResumoPendencia</c:set>--%>


<%
String parametro = request.getParameter("parametro");

%>

<jp:chooseQuery id="query01" queryName="<%=parametro %>"/>

<c:set var="title01" scope="session">OLAP Gcom</c:set>


