#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

new Handle: g_hMenu;
new bool:	g_bIsAnswered[MAXPLAYERS];

public Plugin:myinfo = 
{
	name = "[RuLeS] Welcom",
	description = "Вывод правил сервера в меню при заходе на сервер",
	author = "Pr[E]fix",
	version = "1.0 beta",
	url = "vk.com/cyxaruk1337"
};

public OnPluginStart()
{
	HookEvent("player_team", Event_PlayerTeam);
	g_hMenu = CreateMenu(VotePlayer_Handler);
	AddMenuItem(g_hMenu, "", "Да, я согласен");
	AddMenuItem(g_hMenu, "", "Нет, я не согласен");
	SetMenuExitButton(g_hMenu, false);
	
}

public OnClientDisconnect_Post(client)
{
	g_bIsAnswered[client] = false;
}

public Action:Event_PlayerTeam(Handle:event, const String: name[], bool:dontBroadcast) 
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(!g_bIsAnswered[client])
	{
		SetMenuTitle(g_hMenu, "==============================\nДобро пожаловать, %N\nТы попал на SERVER_NAME\n==============================\n- На сервере микрофон разрешен строго с 18 лет.\n- Если ты не достиг данного возраста\n- Просьба не пищать в микрофон.\nПриятной тебе игры братишка.\n==============================", client);
		DisplayMenu(g_hMenu, client, 0);
		g_bIsAnswered[client] = true;
	}
}

public VotePlayer_Handler(Handle:h, MenuAction:a, c, o) 
{
	if(a == MenuAction_Select && o == 1)
	{
		KickClient(c, "Ты был кикнут за то что не согласен с правилами сервера!");
	}
}