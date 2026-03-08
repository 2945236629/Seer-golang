package com.robot.app.mapProcess
{
   import com.robot.app.control.StarapprehendorderControler;
   import com.robot.app.fight.FightManager;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.info.pet.PetInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_11302 extends BaseMapProcess
   {
      
      private static var type:int = -1;
      
      private var talkstate:int;
      
      public function MapProcess_11302()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var typearr:Array = null;
         var defaltcatchtime:uint = 0;
         var petinfo:PetInfo = null;
         var e:MouseEvent = param1;
         var ename:String = e.target.name;
         switch(ename)
         {
            case "npc":
               typearr = ["草","水","火"];
               if(type == -1)
               {
                  type = Math.round(Math.random() * 2);
               }
               defaltcatchtime = uint(PetManager.defaultTime);
               petinfo = PetManager.getPetInfo(defaltcatchtime);
               NpcDialog.show(NPC.MENG_YI_YOU,["好想和" + typearr[type] + "属性的精灵一起玩啊（请将" + typearr[type] + "属性的精灵设为首发精灵）"],["我这里就有，你们要不要一起玩？","我去找找我的精灵仓库"],[function():void
               {
                  if(Boolean(petinfo) && int(PetXMLInfo.getType(petinfo.id)) == type + 1)
                  {
                     NpcDialog.show(NPC.MENG_YI_YOU,["谢谢你！走，我们一起游泳去！这张纸条就交给你啦！"],["祝你们玩得开心！"],[function():void
                     {
                        SocketConnection.sendByQueue(45677,[4,0],function(param1:*):void
                        {
                           StarapprehendorderControler.instance.overtask();
                        });
                     }],false);
                  }
                  else
                  {
                     NpcDialog.show(NPC.MENG_YI_YOU,["不不不，我只想和" + typearr[type] + "属性的精灵一起玩！（请将" + typearr[type] + "属性的精灵设为首发精灵）"],["好吧"],[null],false,null);
                  }
               },null],false);
         }
      }
      
      private function fight() : void
      {
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            var _loc3_:FightOverInfo = param1.dataObj as FightOverInfo;
            if(_loc3_.winnerID != MainManager.actorID)
            {
               talkstate = 0;
            }
            else
            {
               MapManager.changeMap(1202);
               ModuleManager.showAppModule("StarapprehendorderMainPanel");
               StarapprehendorderControler.instance.overtask();
            }
         });
         FightManager.fightNoMapBoss("",7682);
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

