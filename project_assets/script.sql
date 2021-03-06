CREATE DATABASE [pharma_dw]
USE [pharma_dw]
GO
CREATE TABLE [dbo].[dim_article](
	[idArticle] [varchar](255) NOT NULL,
	[categorie] [varchar](255) NOT NULL,
	[designation] [varchar](255) NOT NULL,
	[stockAlerte] [numeric](6, 0) NOT NULL,
	[DCI1] [varchar](255),
	[DCI2] [varchar](255),
	[DCI3] [varchar](255),
	[prixVenteHT] [decimal](18, 3) NOT NULL,
	[prixVenteTTC] [decimal](18, 3) NOT NULL,
	[prixAchatHT] [decimal](18, 3) NOT NULL,
	[prixAchatTTC] [decimal](18, 3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idArticle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[dim_facture](
	[idFacture] [varchar](255) NOT NULL,
	[remise] [decimal](18, 3) NOT NULL,
	[dateFacture] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idFacture] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[dim_fournisseur](
	[idFournisseur] [varchar](255) NOT NULL,
	[nom] [varchar](255) NOT NULL,
	[adresse] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idFournisseur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[dim_time](
	[idTime] [bigint] IDENTITY(1,1) NOT NULL,
	[year] [int] NOT NULL,
	[month] [int] NOT NULL,
	[day] [int] NOT NULL,
	[hour] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[dim_vendeur](
	[idVendeur] [varchar](50) NOT NULL,
	[nom] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idVendeur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[fact_achat](
	[idFacture] [varchar](255) NOT NULL,
	[idArticle] [varchar](255) NOT NULL,
	[idFournisseur] [varchar](255) NOT NULL,
	[idTime] [bigint] NOT NULL,
	[qte] [int] NOT NULL,
 CONSTRAINT [PK_ACHAT_FACT_PHARMADW] PRIMARY KEY CLUSTERED 
(
	[idFacture] ASC,
	[idArticle] ASC,
	[idFournisseur] ASC,
	[idTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[fact_mvt_stock](
	[idArticle] [varchar](255) NOT NULL,
	[idTime] [bigint] NOT NULL,
	[typeMvt] [varchar](255) NOT NULL,
	[ancienStock] [int] NOT NULL,
	[nouveauStock] [int] NOT NULL,
	[qte] [int] NOT NULL,
 CONSTRAINT [PK_MVTSTOCK_FACT_PHARMADW] PRIMARY KEY CLUSTERED 
(
	[idArticle] ASC,
	[idTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[fact_vente](
	[idFacture] [varchar](255) NOT NULL,
	[idArticle] [varchar](255) NOT NULL,
	[idVendeur] [varchar](50) NOT NULL,
	[idTime] [bigint] NOT NULL,
	[qte] [int] NOT NULL,
 CONSTRAINT [PK_VENTE_FACT_PHARMADW] PRIMARY KEY CLUSTERED 
(
	[idFacture] ASC,
	[idArticle] ASC,
	[idVendeur] ASC,
	[idTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[fact_achat]  WITH CHECK ADD  CONSTRAINT [FK_ARTICLE_ACHAT] FOREIGN KEY([idArticle])
REFERENCES [dbo].[dim_article] ([idArticle])
GO
ALTER TABLE [dbo].[fact_achat] CHECK CONSTRAINT [FK_ARTICLE_ACHAT]
GO
ALTER TABLE [dbo].[fact_achat]  WITH CHECK ADD  CONSTRAINT [FK_FOURNISSEUR_ACHAT] FOREIGN KEY([idFournisseur])
REFERENCES [dbo].[dim_fournisseur] ([idFournisseur])
GO
ALTER TABLE [dbo].[fact_achat] CHECK CONSTRAINT [FK_FOURNISSEUR_ACHAT]
GO
ALTER TABLE [dbo].[fact_achat]  WITH CHECK ADD  CONSTRAINT [FK_TIME_ACHAT] FOREIGN KEY([idTime])
REFERENCES [dbo].[dim_time] ([idTime])
GO
ALTER TABLE [dbo].[fact_achat] CHECK CONSTRAINT [FK_TIME_ACHAT]
GO
ALTER TABLE [dbo].[fact_achat]  WITH CHECK ADD  CONSTRAINT [FKACHAT_FACTURE_ACHAT] FOREIGN KEY([idFacture])
REFERENCES [dbo].[dim_facture] ([idFacture])
GO
ALTER TABLE [dbo].[fact_achat] CHECK CONSTRAINT [FKACHAT_FACTURE_ACHAT]
GO
ALTER TABLE [dbo].[fact_mvt_stock]  WITH CHECK ADD  CONSTRAINT [FK_ARTICLE_MVTSTOCK] FOREIGN KEY([idArticle])
REFERENCES [dbo].[dim_article] ([idArticle])
GO
ALTER TABLE [dbo].[fact_mvt_stock] CHECK CONSTRAINT [FK_ARTICLE_MVTSTOCK]
GO
ALTER TABLE [dbo].[fact_mvt_stock]  WITH CHECK ADD  CONSTRAINT [FK_TIME_MVTSTOCK] FOREIGN KEY([idTime])
REFERENCES [dbo].[dim_time] ([idTime])
GO
ALTER TABLE [dbo].[fact_mvt_stock] CHECK CONSTRAINT [FK_TIME_MVTSTOCK]
GO
ALTER TABLE [dbo].[fact_vente]  WITH CHECK ADD  CONSTRAINT [FK_ARTICLE_VENTEN] FOREIGN KEY([idArticle])
REFERENCES [dbo].[dim_article] ([idArticle])
GO
ALTER TABLE [dbo].[fact_vente] CHECK CONSTRAINT [FK_ARTICLE_VENTEN]
GO
ALTER TABLE [dbo].[fact_vente]  WITH CHECK ADD  CONSTRAINT [FK_TIME_VENTEN] FOREIGN KEY([idTime])
REFERENCES [dbo].[dim_time] ([idTime])
GO
ALTER TABLE [dbo].[fact_vente] CHECK CONSTRAINT [FK_TIME_VENTEN]
GO
ALTER TABLE [dbo].[fact_vente]  WITH CHECK ADD  CONSTRAINT [FK_VENDEUR_VENTEN] FOREIGN KEY([idVendeur])
REFERENCES [dbo].[dim_vendeur] ([idVendeur])
GO
ALTER TABLE [dbo].[fact_vente] CHECK CONSTRAINT [FK_VENDEUR_VENTEN]
GO
