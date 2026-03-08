package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   
   public class MapProcess_11705 extends BaseMapProcess
   {
      
      private var pro:int;
      
      private var _lefttime:int;
      
      private var colidx:int = -1;
      
      private var hidenum:int;
      
      public function MapProcess_11705()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("0817主题活动","进入送礼场景","2018运营活动");
         KTool.petFollow(3710);
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.update(true);
      }
      
      private function update(param1:Boolean = false) : void
      {
         var boo:Boolean = param1;
         LevelManager.closeMouseEvent();
         KTool.getMultiValue([16929],function(param1:Array):void
         {
            pro = param1[0];
            conLevel["mc"].gotoAndStop(pro == 6 ? 1 : 2);
            if(pro > 6)
            {
               KTool.petDestroy();
            }
            LevelManager.openMouseEvent();
         });
      }
      
      private function showdialog() : void
      {
         NpcDialog.show(3710,["……"],null,null,false,function():void
         {
            NpcDialog.show(NPC.SEER,["菇菇发！蘑牙牙给你准备了一份礼物，这可是我们费了九牛二虎之力才弄到的，你一定要收下！蘑牙牙你……咦，蘑牙牙？"],null,null,false,function():void
            {
               NpcDialog.show(NPC.SEER,["你为啥不说话，躲在我身后呀？"],null,null,false,function():void
               {
                  NpcDialog.show(3710,["……这个果子，送你！"],null,null,false,function():void
                  {
                     NpcDialog.show(3708,["谢……谢谢你……蘑牙牙，你对我真好。"],["蘑牙牙永远想着菇菇发！"],[function():void
                     {
                        NpcDialog.show(NPC.SEER,["（这两个人之间的气氛有点诡异，我要不要先溜？）"],null,null,false,function():void
                        {
                           NpcDialog.show(3708,["不要走！我……我也有东西送给你们，请一定要收下！"],["谢谢你！七夕快乐！"],[function():void
                           {
                              SocketConnection.sendByQueue(43300,[18,4],function(param1:*):void
                              {
                                 update();
                                 Alarm.show("你与蘑牙牙的友情点增加了35点！");
                                 ModuleManager.showAppModule("MoyayaGiftMainPanel");
                              });
                           }],false,null,true);
                        });
                     }],false,null,true);
                  },true);
               });
            });
         },true);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "npc":
               if(this.pro == 6)
               {
                  this.showdialog();
               }
         }
      }
      
      override public function destroy() : void
      {
         KTool.petDestroy();
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

